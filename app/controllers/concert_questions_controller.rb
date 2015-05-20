class ConcertQuestionsController

  def ask_questions
    concert_info = Hash.new
    venue_info = Hash.new
    say("Answer the following questions about the concert:\n")
    concert_info[:artist] = ask("Who was the artist?") { |i| Concert.validate_artist(i) }
    concert_info[:concert_date] = ask("When was the concert? (YYYY-MM-DD)") { |i| Concert.validate_date(i) }
    venue_info[:name] = ask("What was the name of the venue?") { |i| Venue.validate_name(i) }
    venue = Venue.find_by_name(venue_info[:name])
    if venue.nil?
      ask_venue_questions(venue_info)
    else
      choose do |menu|
        menu.prompt = "#{venue_info[:name]}, located in #{venue.city}, #{venue.state}, #{venue.country} found in database. Use this venue? (y/n)"
        menu.choice(:y) { concert_info[:venue_id] = venue.id }
        menu.choice(:n) {
          venue_info[:name] = ask("What was the name of the venue?") { |i| Venue.validate_name(i) }
          ask_venue_questions(venue_info)
        }
      end
    end
    concert_info[:rating] = ask("Rate your experience on a scale of 1-10") { |i| Concert.validate_rating(i) }
    venue = Venue.find_by_name(venue_info[:name])
    confirmation = ask("Cool! You saw #{concert_info[:artist]} play #{venue.name} in #{venue.city} on #{concert_info[:concert_date]}. You gave this show a #{concert_info[:rating]}. Is that correct? (y/n)")
    if confirmation == "y"
      puts "Concert saved\n"
      concert_info[:venue_id] = venue.id
      concerts_controller = ConcertsController.new
      concerts_controller.add(concert_info)
      concerts_controller.list
    else
      main_menu_prompt
    end
  end

  def ask_venue_questions(venue_info)
    venue_info[:city] = ask("In what city is the venue located?") { |i| Venue.validate_city(i) }
    venue_info[:state] = ask("In what state is the venue located? (use abbreviation or leave blank to omit)") { |i| Venue.validate_state(i) }
    venue_info[:country] = ask("In what country is the venue located? (leave blank to omit)") { |i| Venue.validate_state(i) }
    venues_controller = VenuesController.new
    venues_controller.add(venue_info)
  end

end
