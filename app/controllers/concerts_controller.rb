class ConcertsController

  def index
    if Concert.count > 0
      concerts = Concert.all
      concerts_string = ""
      concerts.each_with_index do |concert, index|
        concerts_string << "#{index + 1}. #{concert.artist}\n"
      end
      concerts_string
    else
      "No concerts found. Add a concert.\n"
    end
  end

  def collect_concert_info
    concert_info = Hash.new
    concerts_controller = ConcertsController.new
    say("Answer the following questions about the concert:\n")
    concert_info["artist"] = ask("Who was the headlining act?")
    # openers_choice = ask("Were there any noteworthy openers? (y/n)")
    # if openers_choice == "y"
    #   openers = ask("List the opening act(s), seperated by commas (KISS,Meatloaf)").split(",")
    # end
    concert_info["concert_date"] = ask("When was the concert? (mm/dd/yyyy)")
    concert_info["venue"] = ask("What was the name of the venue?")
    concert_info["location"] = ask("Where is the venue located? (City, ST)")
    concert_info["rating"] = ask("Rate your experience on a scale of 1-10")
    confirmation = ask("Cool! You saw #{concert_info["artist"]} play #{concert_info["venue"]} in #{concert_info["location"]} on #{concert_info["concert_date"]}. You gave this show a #{concert_info["rating"]}. Is that correct? (y/n)")
    if confirmation == "y"
      puts "Concert saved"
      add(concert_info)
      puts concert_info
    else
      puts "Let's try again"
    end

  end

  def add(concert_info)
    Concert.create(concert_info)
  end

end
