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
    say("Answer the following questions about the concert:\n")
    concert_info["artist"] = ask("Who was the headlining act?") { |i| validate_artist(i) }
    # openers_choice = ask("Were there any noteworthy openers? (y/n)")
    # if openers_choice == "y"
    #   openers = ask("List the opening act(s), seperated by commas (KISS,Meatloaf)").split(",")
    # end
    concert_info["concert_date"] = ask("When was the concert? (mm/dd/yyyy)") { |i| validate_date(i) }
    concert_info["venue"] = ask("What was the name of the venue?") { |i| validate_venue(i) }
    concert_info["location"] = ask("Where is the venue located? (City, ST)") { |i| validate_location(i) }
    concert_info["rating"] = ask("Rate your experience on a scale of 1-10") { |i| validate_rating(i) }
    confirmation = ask("Cool! You saw #{concert_info["artist"]} play #{concert_info["venue"]} in #{concert_info["location"]} on #{concert_info["concert_date"]}. You gave this show a #{concert_info["rating"]}. Is that correct? (y/n)")
    if confirmation == "y"
      puts "Concert saved"
      add(concert_info)
      puts concert_info
    else
      puts "Let's try again"
    end
  end

  def validate_artist(input)
    input.validate = lambda { |p| p != "" };
    input.responses[:not_valid] = "Headliner cannot be empty."
  end

  def validate_date(input)
    input.validate = /(0[1-9]|1[012])[- \/](0[1-9]|[12][0-9]|3[01])[- \/](19|20)\d\d/;
    input.responses[:not_valid] = "Invalid date. Enter date in MM/DD/YYYY format."
  end

  def validate_venue(input)
    input.validate = lambda { |p| p != "" };
    input.responses[:not_valid] = "Venue cannot be empty."
  end

  def validate_location(input)
    input.validate = lambda { |p| p != "" };
    input.responses[:not_valid] = "Enter location in City, ST format (example: Nashville, TN)"
  end

  def validate_rating(input)
    input.validate = lambda { |p| p.to_i.between?(1,10) };
    input.responses[:not_valid] = "Rating must be a number 1-10."
  end

  def add(concert_info)
    Concert.create(concert_info)
  end

end
