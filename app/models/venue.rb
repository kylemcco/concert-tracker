class Venue < ActiveRecord::Base
  validates :name,
    presence: true

  default_scope { order("name ASC") }

  def self.validate_name
    ask("What was the name of the venue?") { |i|
      i.validate = lambda { |p| p != "" };
      i.responses[:not_valid] = "Venue cannot be empty."
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
