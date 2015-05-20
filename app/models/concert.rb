class Concert
  attr_reader :id
  attr_accessor :artist, :concert_date, :venue_id, :rating

  def initialize(attrs = nil)
    attrs.each {|key, value| send("#{key}=",value) } unless attrs.nil?
  end

  def self.all
    Database.execute("select * from concerts order by artist ASC").map do |row|
      populate_from_database(row)
    end
  end

  def self.find(id)
    row = Database.execute("select * from concerts where id = ?", id).first
    if row.nil?
      nil
    else
      populate_from_database(row)
    end
  end

  def self.count
    Database.execute("select count(id) from concerts")[0][0]
  end

  def save
    Database.execute("INSERT INTO concerts (artist, concert_date, venue_id, rating)
    VALUES (?, ?, ?, ?)", artist, concert_date, venue_id, rating)
    @id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
  end

  def self.validate_artist(input)
    input.validate = lambda { |p| p != "" };
    input.responses[:not_valid] = "Headliner cannot be empty."
  end

  def self.validate_date(input)
    # input.validate = /(0[1-9]|1[012])[- \/](0[1-9]|[12][0-9]|3[01])[- \/](19|20)\d\d/;
    input.validate = /^(19|20)\d\d[- .](0[1-9]|1[012])[- .](0[1-9]|[12][0-9]|3[01])$/;
    input.responses[:not_valid] = "Invalid date. Enter date in YYYY/MM/DD format."
  end

  def self.validate_rating(input)
    input.validate = lambda { |p| p.to_i.between?(1,10) };
    input.responses[:not_valid] = "Rating must be a number 1-10."
  end

  private

  def self.populate_from_database(row)
    concert = Concert.new
    concert.artist = row['artist']
    concert.concert_date = row['concert_date']
    concert.venue_id = row['venue_id']
    concert.rating = row['rating']
    concert.instance_variable_set(:@id, row['id'])
    concert
  end

end
