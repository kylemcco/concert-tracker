require 'rubygems'
require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/reporters'

Dir["./app/**/*.rb"].each { |f| require f }
Dir["./lib/*.rb"].each { |f| require f }
ENV["TEST"] = "true"

reporter_options = {color: true}
Minitest::Reporters::use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

require 'minitest/autorun'
class Minitest::Test
  def setup
    Database.load_structure
    Database.execute("DELETE FROM concerts;")
    Database.execute("DELETE FROM venues;")
  end
end

def add_concert(concert_info)
  Database.execute("INSERT INTO concerts (artist, concert_date, venue, location, rating)
  VALUES (?, ?, ?, ?, ?)", concert_info[:artist], concert_info[:concert_date], concert_info[:venue], concert_info[:location], concert_info[:rating])
end

def main_menu
<<EOS
1. Add a concert
2. Manage concerts
3. View statistics
4. Exit
EOS
end
