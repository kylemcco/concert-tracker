require_relative '../test_helper'

describe Venue do

  describe ".initialize" do
    let(:venue){ Venue.new({:name=> "The Ryman", :city=>"Nashville"})}
    it "sets venue attributes" do
      assert_equal "The Ryman", venue.name
      assert_equal "Nashville", venue.city
    end
  end

  describe ".valid?" do
    describe "with no name provided" do
      let(:venue){ Venue.create(name: nil) }
      it "returns false" do
        refute venue.valid?
      end
      it "sets the error message if name is nil" do
        venue.valid?
        assert_equal ["can't be blank"], venue.errors[:name]
      end
    end
    describe "with no city provided" do
      let(:venue){ Venue.create(city: nil) }
      it "returns false" do
        refute venue.valid?
      end
      it "sets the error message if city is nil" do
        venue.valid?
        assert_equal ["can't be blank", "must only contain letters, spaces and dashes"], venue.errors[:city]
      end
    end
    describe "with illegal characters in city" do
      let(:venue){ Venue.create(city: "Nas@#hville!") }
      it "returns false" do
        refute venue.valid?
      end
      it "sets the error message if city contains illegal characters" do
        venue.valid?
        assert_equal ["must only contain letters, spaces and dashes"], venue.errors[:city]
      end
    end
    describe "with illegal characters in state" do
      let(:venue){ Venue.create(state: "?N") }
      it "returns false" do
        refute venue.valid?
      end
      it "sets the error message if state contains illegal characters" do
        venue.valid?
        assert_equal ["must only contain letters"], venue.errors[:state]
      end
    end
    describe "with no state provided" do
      let(:venue){ Venue.create(name: "The Ryman", city: "Nashville") }
      it "returns true" do
        assert venue.valid?
      end
    end
    describe "with too many characters in state" do
      let(:venue){ Venue.create(state: "Tennessee") }
      it "returns false" do
        refute venue.valid?
      end
      it "sets the error message if state contains too many characters" do
        venue.valid?
        assert_equal ["is the wrong length (should be 2 characters)"], venue.errors[:state]
      end
    end
    describe "with no country provided" do
      let(:venue){ Venue.create(name: "The Ryman", city: "Nashville") }
      it "returns true" do
        assert venue.valid?
      end
    end
    describe "with illegal characters in country" do
      let(:venue){ Venue.create(country: "US@#A!") }
      it "returns false" do
        refute venue.valid?
      end
      it "sets the error message if country contains illegal characters" do
        venue.valid?
        assert_equal ["must only contain letters, spaces and dashes"], venue.errors[:country]
      end
    end
  end

  describe "#all" do
    describe "if there are no venues in the database" do
      it "should return an empty array" do
        assert_equal [], Venue.all
      end
    end
    describe "if there are venues" do
      before do
        Venue.new({:name=>"The Ryman", :city=>"Nashville"}).save
        Venue.new({:name=>"Orange Peel", :city=>"Asheville"}).save
        Venue.new({:name=>"Bijou Theater", :city=>"Knoxville"}).save
      end
      it "should return the venues in alphabetical order" do
        expected = ["Bijou Theater", "Orange Peel", "The Ryman"]
        actual = Venue.all.map{ |venue| venue.name }
        assert_equal expected, actual
      end
      it "populates the returned venues' ids" do
        expected_ids = Database.execute("SELECT id FROM venues order by name ASC").map{ |row| row['id'] }
        actual_ids = Venue.all.map{ |venue| venue.id }
        assert_equal expected_ids, actual_ids
      end
    end
  end

  describe "#count" do
    describe "if there are no venues in the database" do
      it "should return 0" do
        assert_equal 0, Venue.count
      end
    end
    describe "if there are venues" do
      before do
        Venue.new({:name=>"The Ryman", :city=>"Nashville"}).save
        Venue.new({:name=>"Orange Peel", :city=>"Asheville"}).save
        Venue.new({:name=>"Bijou Theater", :city=>"Knoxville"}).save
      end
      it "should return the correct count" do
        assert_equal 3, Venue.count
      end
    end
  end

  describe ".save" do
    describe "if we want to save a venue to the database" do
      let(:venue){Venue.new({:name=> "The Ryman", :city=>"Nashville"})}
      it "should add a venue" do
        venue.save
        assert_equal 1, Venue.count
      end
      it "should populate the model with id from the database" do
        venue.save
        last_row = Database.execute("SELECT * FROM venues")[0]
        database_id = last_row['id']
        assert_equal database_id, venue.id
      end
    end
  end

end
