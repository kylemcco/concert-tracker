class ConcertQuestionsController

  def ask_questions
    concert = Concert.new
    venue = Venue.new
    say("Answer the following questions about the concert:\n")
    concert.artist = Concert.validate_artist
    concert.concert_date = Concert.validate_date
    venue.name = Venue.validate_name
    if (Venue.find_by name: venue.name).nil?
      ask_venue_questions(venue)
    else
      choose do |menu|
        venue = Venue.find_by name: venue.name
        menu.prompt = "#{venue.name}, located in #{venue.city}, #{venue.state}, #{venue.country} found in database. Use this venue? (y/n)"
        menu.choice(:y) { concert.venue_id = venue.id }
        menu.choice(:n) {
          venue.name = Venue.validate_name
          ask_venue_questions(venue)
        }
      end
    end
    concert.rating = Concert.validate_rating
    venue = Venue.find_by name: venue.name
    confirmation = ask("Cool! You saw #{concert.artist} play #{venue.name} in #{venue.city} on #{concert.concert_date}. You gave this show a #{concert.rating}. Is that correct? (y/n)")
    if confirmation == "y"
      say("Concert saved\n")
      concert.venue_id = venue.id
      concerts_controller = ConcertsController.new
      concert.save
      concerts_controller.list
    else
      main_menu_prompt
    end
  end

  def ask_venue_questions(venue)
    venue.city = Venue.validate_city
    venue.state = Venue.validate_state
    venue.country = Venue.validate_country
    venue.save
  end

end
