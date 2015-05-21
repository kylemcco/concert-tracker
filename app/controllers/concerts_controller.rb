class ConcertsController

  def index
    if Concert.count > 0
      concerts = Concert.all
      concerts_string = ""
      concerts.each_with_index do |concert, index|
        concerts_string << "#{index + 1}. #{concert.artist} on #{concert.concert_date}\n"
      end
      concerts_string
    else
      "No concerts found. Add a concert.\n"
    end
  end

  def list
    if Concert.count > 0
      concerts = Concert.all
      say("Your concerts:\n")
      choose do |menu|
        menu.prompt = ""
        concerts.each do |concert|
          menu.choice("#{concert.artist} (#{concert.concert_date})") {
            manage_concert(concert)
          }
        end
        menu.choice("Go back") { main_menu_prompt }
      end
    else
      "No concerts found. Add a concert.\n"
    end
  end

  def manage_concert(concert)
    loop do
      choose do |menu|
        say("You saw #{concert.artist} play #{concert.venue_id} on #{concert.concert_date}. You gave this show a #{concert.rating}.")
        menu.choice("Edit concert") {
          loop do
            choose do |submenu|
              submenu.choice("Edit artist"){
                concert.artist = Concert.validate_artist
                concert.save
                say("Artist updated to #{concert.artist}\n")
              }
              submenu.choice("Edit concert date"){
                concert.concert_date = Concert.validate_date
                concert.save
                say("Date updated to #{concert.concert_date}\n")
              }
              submenu.choice("Edit rating"){
                concert.rating = Concert.validate_rating
                concert.save
                say("Rating updated to #{concert.rating}\n")
              }
              submenu.choice("Go back") { manage_concert(concert) }
            end
          end
        }
        menu.choice("Delete concert"){
          concert.delete
          say("#{concert.artist} deleted\n")
          list
        }
        menu.choice("Go back") {list}
      end
    end
  end

  def add(concert_info)
    Concert.new(concert_info).save
  end

end
