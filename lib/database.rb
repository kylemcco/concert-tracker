require 'sqlite3'

class Database

  def self.load_structure
    Database.execute <<-SQL
    CREATE TABLE IF NOT EXISTS concerts (
      id integer PRIMARY KEY AUTOINCREMENT,
      artist varchar(255) NOT NULL,
      concert_date varchar(255) NOT NULL,
      venue_id varchar(255) NOT NULL,
      rating varchar(255) NOT NULL,
      FOREIGN KEY (venue_id) REFERENCES venues(id)
    );
    SQL

    Database.execute <<-SQL
    CREATE TABLE IF NOT EXISTS venues (
      id integer PRIMARY KEY AUTOINCREMENT,
      name varchar(255) NOT NULL,
      city varchar(255) NOT NULL,
      state varchar(255),
      country varchar(255)
    );
    SQL
  end

  def self.execute(*args)
    initialize_database unless defined?(@@db)
    @@db.execute(*args)
  end

  def self.initialize_database
    environment = ENV["TEST"] ? "test" : "production"
    database = "db/concert_tracker_#{environment}.sqlite"
    @@db = SQLite3::Database.new(database)
    @@db.results_as_hash = true
  end
end
