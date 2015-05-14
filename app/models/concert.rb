class Concert
  attr_accessor :artist, :concert_date, :venue, :location, :rating

  def self.all
    Database.execute("select artist from concerts order by artist ASC").map do |row|
      concert = Concert.new
      concert.artist = row[0]
      concert
    end
  end

  def self.count
    Database.execute("select count(id) from concerts")[0][0]
  end

  def self.save(concert_info)
    Database.execute("INSERT INTO concerts (artist, concert_date, venue, location, rating)
    VALUES (?, ?, ?, ?, ?)", concert_info["artist"], concert_info["concert_date"], concert_info["venue"], concert_info["location"], concert_info["rating"])
  end

  def self.validate_artist(input)
    lambda { |p| p != "" }
  end

  def self.validate_date(input)
    input = /(0[1-9]|1[012])[- \/](0[1-9]|[12][0-9]|3[01])[- \/](19|20)\d\d/;
  end

  def self.validate_venue(input)
    lambda { |p| p != "" }
  end

  def self.validate_location(input)
    lambda { |p| p != "" }
  end

  def self.validate_rating(input)
    lambda { |p| p.to_i.between?(1,10) }
  end

end
