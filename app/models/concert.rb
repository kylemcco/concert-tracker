class Concert
  attr_accessor :name

  def self.all
    Database.execute("select name from concerts order by name ASC").map do |row|
      concert = Concert.new
      concert.name = row[0]
      concert
    end
  end

  def self.count
    Database.execute("select count(id) from concerts")[0][0]
  end
end
