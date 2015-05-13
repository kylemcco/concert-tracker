class ConcertsController

  def index
    if Concert.count > 0
      concerts = Concert.all
      concerts_string = ""
      concerts.each_with_index do |concert, index|
        concerts_string << "#{index + 1}. #{concert.name}\n"
      end
      concerts_string
    else
      "No concerts found. Add a concert.\n"
    end
  end

end
