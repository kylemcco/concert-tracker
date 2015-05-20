class Venue
  attr_reader :id
  attr_accessor :name, :city, :state, :country

  def initialize(attrs = nil)
    attrs.each {|key, value| send("#{key}=",value) } unless attrs.nil?
  end

  def self.all
    Database.execute("select * from venues order by name ASC").map do |row|
      populate_from_database(row)
    end
  end

  def self.find_by_name(name)
    row = Database.execute("select * from venues where name = ?", name).first
    if row.nil?
      nil
    else
      populate_from_database(row)
    end
  end

  def self.count
    Database.execute("select count(id) from venues")[0][0]
  end

  def save
    results = Venue.find_by_name(name)
    if results.nil?
      Database.execute("INSERT INTO venues (name, city, state, country)
      VALUES (?, ?, ?, ?)", name, city, state, country)
      @id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
    end
  end

  def self.validate_name(input)
    input.validate = lambda { |p| p != "" };
    input.responses[:not_valid] = "Venue cannot be empty."
  end

  def self.validate_city(input)
    input.validate = /^[a-zA-Z\u0080-\u024F\s\/\-\)\(\`\.\"\']+$/
    input.responses[:not_valid] = "City must only contain letters, spaces and dashes"
  end

  def self.validate_state(input)
    input.validate = lambda { |p| p == "" or p.match(/^[a-zA-Z\u0080-\u024F\s\/\-\)\(\`\.\"\']+$/) };
    input.responses[:not_valid] = "State must only contain letters, spaces and dashes"
  end

  def self.validate_country(input)
    input.validate = lambda { |p| p == "" or p.match(/^[a-zA-Z\u0080-\u024F\s\/\-\)\(\`\.\"\']+$/) };
    input.responses[:not_valid] = "Country must only contain letters, spaces and dashes"
  end

  private

  def self.populate_from_database(row)
    venue = Venue.new
    venue.name = row['name']
    venue.city = row['city']
    venue.state = row['state']
    venue.country = row['country']
    venue.instance_variable_set(:@id, row['id'])
    venue
  end

end
