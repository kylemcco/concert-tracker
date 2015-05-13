class ConcertsController

  def index
    if Concert.count > 0
      concerts = Concert.all # All of the scenarios in an array
      concerts.each_with_index do |concert, index|
        say("#{index + 1}. #{concert.name}") #=> 1. Concert 1
      end
    else
      say("No concerts found. Add a concert.\n")
    end
  end

end
