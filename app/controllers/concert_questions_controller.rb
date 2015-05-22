class ConcertQuestionsController

  def ask_questions
    concert_info = Hash.new
    venue_info = Hash.new
    say("Answer the following questions about the concert:\n")
    concert_info[:artist] = Concert.validate_artist
    concert_info[:concert_date] = Concert.validate_date
    venue_info[:name] = Venue.validate_name
    venue = Venue.find_by name: venue_info[:name]
    if venue.nil?
      ask_venue_questions(venue_info)
    else
      choose do |menu|
        menu.prompt = "#{venue_info[:name]}, located in #{venue.city}, #{venue.state}, #{venue.country} found in database. Use this venue? (y/n)"
        menu.choice(:y) { concert_info[:venue_id] = venue.id }
        menu.choice(:n) {
          venue_info[:name] = Venue.validate_name
          ask_venue_questions(venue_info)
        }
      end
    end
    concert_info[:rating] = Concert.validate_rating
    venue = Venue.find_by name: venue_info[:name]
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
    venue_info[:city] = Venue.validate_city
    venue_info[:state] = Venue.validate_state
    venue_info[:country] = Venue.validate_country
    venues_controller = VenuesController.new
    venues_controller.add(venue_info)
  end

end
