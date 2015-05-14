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

  def self.create(concert_info)
    Database.execute("INSERT INTO concerts (artist, concert_date, venue, location, rating)
    VALUES (?, ?, ?, ?, ?)", concert_info["artist"], concert_info["concert_date"], concert_info["venue"], concert_info["location"], concert_info["rating"])
  end

end
