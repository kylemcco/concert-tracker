class Concert < ActiveRecord::Base
  validates :artist,
    presence: true
  validates :concert_date,
    presence: {},
    format: { with: /(19|20)\d\d[- .](0[1-9]|1[012])[- .](0[1-9]|[12][0-9]|3[01])/, message: "must follow YYYY-MM-DD format" }

  default_scope { order("artist ASC") }

#   attr_reader :id
#   attr_accessor :artist, :concert_date, :venue_id, :rating
#
  # def initialize(attrs = nil)
  #   attrs.each {|key, value| send("#{key}=",value) } unless attrs.nil?
  # end
#
#   def self.all
#     Database.execute("select * from concerts order by artist ASC").map do |row|
#       populate_from_database(row)
#     end
#   end
#
#   def self.find(id)
#     row = Database.execute("select * from concerts where id = ?", id).first
#     if row.nil?
#       nil
#     else
#       populate_from_database(row)
#     end
#   end
#
#   def self.count
#     Database.execute("select count(id) from concerts")[0][0]
#   end
#
#   def save
#     if @id.nil?
#       Database.execute("INSERT INTO concerts (artist, concert_date, venue_id, rating)
#       VALUES (?, ?, ?, ?)", artist, concert_date, venue_id, rating)
#       @id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
#     else
#       Database.execute("UPDATE concerts SET artist=?, concert_date=?, venue_id=?, rating=? WHERE id=?", artist, concert_date, venue_id, rating, id)
#     end
#   end
#
#   def delete
#     Database.execute("DELETE FROM concerts WHERE artist=?", artist)
#   end
#
  def self.validate_artist
    ask("Who was the artist?") { |i|
      i.validate = lambda { |p| p != "" };
      i.responses[:not_valid] = "Artist cannot be empty."
    }
  end

  def self.validate_date
    ask("When was the concert? (YYYY-MM-DD)") { |i|
      i.validate = /^(19|20)\d\d[- .](0[1-9]|1[012])[- .](0[1-9]|[12][0-9]|3[01])$/;
      i.responses[:not_valid] = "Invalid date. Enter date in YYYY-MM-DD format."
    }
  end

  def self.validate_rating
    ask("Rate your experience on a scale of 1-10") { |i|
      i.validate = lambda { |p| p.to_i.between?(1,10) };
      i.responses[:not_valid] = "Rating must be a number 1-10."
    }
  end

#   private
#
#   def self.populate_from_database(row)
#     concert = Concert.new
#     concert.artist = row['artist']
#     concert.concert_date = row['concert_date']
#     concert.venue_id = row['venue_id']
#     concert.rating = row['rating']
#     concert.instance_variable_set(:@id, row['id'])
#     concert
#   end
#
end
