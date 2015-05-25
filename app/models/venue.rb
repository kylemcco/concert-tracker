class Venue < ActiveRecord::Base
  validates :name,
    presence: true
  validates :city,
    presence: true,
    format: { with: /^[a-zA-Z]+(?:[\s-][a-zA-Z]+)*$/, multiline: true, message: "must only contain letters, spaces and dashes" },
    length: { maximum: 100 }
  validates :state,
    allow_blank: true,
    allow_nil: true,
    format: {with: /[a-zA-Z]{2}/, message: "must only contain letters"},
    length: { is: 2 }
  validates :country,
    allow_blank: true,
    allow_nil: true,
    format: { with: /^[a-zA-Z]+(?:[\s-][a-zA-Z]+)*$/, multiline: true, message: "must only contain letters, spaces and dashes" },
      length: { maximum: 100 }

  default_scope { order("name ASC") }

  def self.validate_name
    ask("What was the name of the venue?") { |i|
      i.validate = /[a-zA-Z]/;
      i.responses[:not_valid] = "Name must contain at least one letter."
    }
  end

  def self.validate_city
    ask("In what city is the venue located?") { |i|
      i.validate = /^[a-zA-Z\u0080-\u024F\s\/\-\)\(\`\.\"\']+$/
      i.responses[:not_valid] = "City must only contain letters, spaces and dashes"
    }
  end

  def self.validate_state
    ask("In what state is the venue located? (use abbreviation or leave blank to omit)") { |i|
      i.validate = lambda { |p| p == "" or p.match(/^[a-zA-Z]{2}$/) };
      i.responses[:not_valid] = "State must follow two-letter abbreviation format (leave blank to omit)"
    }
  end

  def self.validate_country
    ask("In what country is the venue located? (leave blank to omit)") { |i|
      i.validate = lambda { |p| p == "" or p.match(/^[a-zA-Z\u0080-\u024F\s\/\-\)\(\`\.\"\']+$/) };
      i.responses[:not_valid] = "Country must only contain letters, spaces and dashes (leave blank to omit)"
    }
  end

end
