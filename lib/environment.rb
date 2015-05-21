require 'active_record'
Dir["./app/**/*.rb"].each { |f| require f }
Dir["./lib/*.rb"].each { |f| require f }

class Environment
  def self.current
    ENV["TEST"] ? "test" : "production"
  end
end

connection_details = YAML::load(File.open('config/database.yml'))[Environment.current]
ActiveRecord::Base.establish_connection(connection_details)
