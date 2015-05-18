class Concert < Struct.new(:artist, :concert_date, :venue, :location, :rating)
  attr_accessor :artist, :concert_date, :venue, :location, :rating

  # def initialize(h = nil)
  #     super(*h.values_at(:artist, :concert_date, :venue, :location, :rating))
  # end

  def initialize(attrs = nil)
    if !attrs.nil?
      self.artist = attrs[:artist]
      self.concert_date = attrs[:concert_date]
      self.venue = attrs[:venue]
      self.location = attrs[:location]
      self.rating = attrs[:rating]
    end
  end

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

  def save
    Database.execute("INSERT INTO concerts (artist, concert_date, venue, location, rating)
    VALUES (?, ?, ?, ?, ?)", artist, concert_date, venue, location, rating)
  end

  # def save
  #   Database.execute("INSERT INTO concerts (artist, concert_date, venue, location, rating)
  #   VALUES (?, ?, ?, ?, ?)", concert_info[:artist], concert_info[:concert_date], concert_info[:venue], concert_info[:location], concert_info[:rating])
  # end

  def self.validate_artist(input)
    input.validate = lambda { |p| p != "" };
    input.responses[:not_valid] = "Headliner cannot be empty."
  end

  def self.validate_date(input)
    input.validate = /(0[1-9]|1[012])[- \/](0[1-9]|[12][0-9]|3[01])[- \/](19|20)\d\d/;
    input.responses[:not_valid] = "Invalid date. Enter date in MM/DD/YYYY format."
  end

  def self.validate_venue(input)
    input.validate = lambda { |p| p != "" };
    input.responses[:not_valid] = "Venue cannot be empty."
  end

  def self.validate_location(input)
    input.validate = /^(.+)+,[ ]?[A-Za-z]{2}$/
    input.responses[:not_valid] = "Enter location in City, ST format (example: Nashville, TN)."
  end

  def self.validate_rating(input)
    input.validate = lambda { |p| p.to_i.between?(1,10) };
    input.responses[:not_valid] = "Rating must be a number 1-10."
  end

end
