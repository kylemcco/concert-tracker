require_relative '../test_helper'

describe Venue do

  describe ".initialize" do
    let(:venue){ Venue.new({:name=> "The Ryman", :location=>"Nashville, TN"})}
    it "sets venue attributes" do
      assert_equal "The Ryman", venue.name
      assert_equal "Nashville, TN", venue.location
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
        Venue.new({:name=> "The Ryman", :location=>"Nashville, TN"}).save
        Venue.new({:name=> "Orange Peel", :location=>"Asheville, SC"}).save
        Venue.new({:name=> "Bijou Theater", :location=>"Knoxville, TN"}).save
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
        Venue.new({:name=> "The Ryman", :location=>"Nashville, TN"}).save
        Venue.new({:name=> "Orange Peel", :location=>"Asheville, SC"}).save
        Venue.new({:name=> "Bijou Theater", :location=>"Knoxville, TN"}).save
      end
      it "should return the correct count" do
        assert_equal 3, Venue.count
      end
    end
  end

  describe ".save" do
    describe "if we want to save a venue to the database" do
      let(:venue){Venue.new({:name=> "The Ryman", :location=>"Nashville, TN"})}
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
