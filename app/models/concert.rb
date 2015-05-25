class Concert < ActiveRecord::Base
  validates :artist,
    presence: true
  validates :concert_date,
    presence: true,
    format: { with: /(19|20)\d\d[- .](0[1-9]|1[012])[- .](0[1-9]|[12][0-9]|3[01])/,
      message: "must follow YYYY-MM-DD format"}
  validates :rating,
    presence: true,
    numericality: { :greater_than=>0, :less_than_or_equal_to=>10}

  default_scope { order("artist ASC") }

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

end
