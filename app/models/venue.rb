class Venue
  attr_reader :id
  attr_accessor :name, :location

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
      []
    else
      return row['id']
    end
  end

  def exists?
    row = Database.execute("select * from venues where name = ?", name).first
    if row.nil?
      false
    else
      true
    end
  end

  def self.count
    Database.execute("select count(id) from venues")[0][0]
  end

  def save
    unless exists?
      Database.execute("INSERT INTO venues (name, location)
      VALUES (?, ?)", name, location)
      @id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
    end
  end

  def self.validate_name(input)
    input.validate = lambda { |p| p != "" };
    input.responses[:not_valid] = "Venue cannot be empty."
  end

  def self.validate_location(input)
    input.validate = /^(.+)+,[ ]?[A-Za-z]{2}$/
    input.responses[:not_valid] = "Enter location in City, ST format (example: Nashville, TN)."
  end

  private

  def self.populate_from_database(row)
    venue = Venue.new
    venue.name = row['name']
    venue.city = row['location']
    venue.instance_variable_set(:@id, row['id'])
    venue
  end

end
