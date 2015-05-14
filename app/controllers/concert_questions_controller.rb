class ConcertQuestionsController

  def ask_questions
    concert_info = Hash.new
    say("Answer the following questions about the concert:\n")
    concert_info["artist"] = ask("Who was the headlining act?") { |i|
      i.validate = Concert.validate_artist(i)
      i.responses[:not_valid] = "Headliner cannot be empty."
    }
    # openers_choice = ask("Were there any noteworthy openers? (y/n)")
    # if openers_choice == "y"
    #   openers = ask("List the opening act(s), seperated by commas (KISS,Meatloaf)").split(",")
    # end
    concert_info["concert_date"] = ask("When was the concert? (mm/dd/yyyy)") { |i|
      i.validate = Concert.validate_date(i)
      i.responses[:not_valid] = "Invalid date. Enter date in MM/DD/YYYY format."
    }
    concert_info["venue"] = ask("What was the name of the venue?") { |i|
      i.validate = Concert.validate_venue(i)
      i.responses[:not_valid] = "Venue cannot be empty."
    }
    concert_info["location"] = ask("Where is the venue located? (City, ST)") { |i|
      i.validate = Concert.validate_location(i)
      i.responses[:not_valid] = "Enter location in City, ST format (example: Nashville, TN)"
    }
    concert_info["rating"] = ask("Rate your experience on a scale of 1-10") { |i|
      i.validate = Concert.validate_rating(i)
      i.responses[:not_valid] = "Rating must be a number 1-10."
    }
    confirmation = ask("Cool! You saw #{concert_info["artist"]} play #{concert_info["venue"]} in #{concert_info["location"]} on #{concert_info["concert_date"]}. You gave this show a #{concert_info["rating"]}. Is that correct? (y/n)")
    if confirmation == "y"
      puts "Concert saved"
      concerts_controller = ConcertsController.new
      concerts_controller.add(concert_info)
      puts concert_info
    else
      puts "Let's try again"
    end
  end

end
