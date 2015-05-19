class VenuesController

  def add(venue_info)
    Venue.new(venue_info).save
  end

end
