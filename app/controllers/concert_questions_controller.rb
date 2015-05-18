class ConcertQuestionsController

  def ask_questions
    concert_info = Hash.new
    say("Answer the following questions about the concert:\n")
    concert_info[:artist] = ask("Who was the headlining act?") { |i| Concert.validate_artist(i) }
    # openers_choice = ask("Were there any noteworthy openers? (y/n)")
    # if openers_choice == "y"
    #   openers = ask("List the opening act(s), seperated by commas (KISS,Meatloaf)").split(",")
    # end
    concert_info[:concert_date] = ask("When was the concert? (mm/dd/yyyy)") { |i| Concert.validate_date(i) }
    concert_info[:venue] = ask("What was the name of the venue?") { |i| Concert.validate_venue(i) }
    concert_info[:location] = ask("Where is the venue located? (City, ST)") { |i| Concert.validate_location(i) }
    concert_info[:rating] = ask("Rate your experience on a scale of 1-10") { |i| Concert.validate_rating(i) }
    confirmation = ask("Cool! You saw #{concert_info[:artist]} play #{concert_info[:venue]} in #{concert_info[:location]} on #{concert_info[:concert_date]}. You gave this show a #{concert_info[:rating]}. Is that correct? (y/n)")
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
