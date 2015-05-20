require_relative '../test_helper'

describe Concert do

  describe ".initialize" do
    let(:concert){ Concert.new({:artist=>"Wilco", :concert_date=>"2000-02-02", :venue_id=>"1", :rating=>"10"}) }
    it "sets concert attributes" do
      assert_equal "Wilco", concert.artist
      assert_equal "2000-02-02", concert.concert_date
      assert_equal "1", concert.venue_id
      assert_equal "10", concert.rating
    end
  end

  describe "#all" do
    describe "if there are no concerts in the database" do
      it "returns an empty array" do
        assert_equal [], Concert.all
      end
    end
    describe "if there are concerts" do
      before do
        Concert.new({:artist=>"Wilco", :concert_date=>"2000-02-02", :venue_id=>"1", :rating=>"10"}).save
        Concert.new({:artist=>"Andrew Bird", :concert_date=>"2000-02-02", :venue_id=>"1", :rating=>"10"}).save
        Concert.new({:artist=>"Neil Young", :concert_date=>"2000-02-02", :venue_id=>"2", :rating=>"10"}).save
      end
      it "returns the concerts in alphabetical order" do
        expected = ["Andrew Bird", "Neil Young", "Wilco"]
        actual = Concert.all.map{ |concert| concert.artist }
        assert_equal expected, actual
      end
      it "populates the returned concerts' ids" do
        expected_ids = Database.execute("SELECT id FROM concerts order by artist ASC").map{ |row| row['id'] }
        actual_ids = Concert.all.map{ |concert| concert.id }
        assert_equal expected_ids, actual_ids
      end
    end
  end

  describe "#count" do
    describe "if there are no concerts in the database" do
      it "returns 0" do
        assert_equal 0, Concert.count
      end
    end
    describe "if there are concerts" do
      before do
        Concert.new({:artist=>"Wilco", :concert_date=>"2000-02-02", :venue_id=>"1", :rating=>"10"}).save
        Concert.new({:artist=>"Andrew Bird", :concert_date=>"2000-02-02", :venue_id=>"1", :rating=>"10"}).save
        Concert.new({:artist=>"Neil Young", :concert_date=>"2000-02-02", :venue_id=>"2", :rating=>"10"}).save
      end
      it "returns the correct count" do
        assert_equal 3, Concert.count
      end
    end
  end

  describe "#find" do
    let(:concert){Concert.new({:artist=>"Wilco", :concert_date=>"2000-02-02", :venue_id=>"1", :rating=>"10"})}
    before do
      concert.save
    end
    describe "if there isn't a matching concert in the database" do
      it "returns nil" do
        assert_equal nil, Concert.find(14)
      end
    end
    describe "if there is a matching concert in the database" do
      it "returns the concert, populated with id and artist" do
        actual = Concert.find(concert.id)
        assert_equal concert.id, actual.id
        assert_equal concert.artist, actual.artist
      end
    end
  end

  describe ".save" do
    describe "if we save a new concert to the database" do
      let(:concert){Concert.new({:artist=>"Wilco", :concert_date=>"2000-02-02", :venue_id=>"1", :rating=>"10"})}
      it "adds a concert to the database" do
        concert.save
        assert_equal 1, Concert.count
      end
      it "populates the model with id from the database" do
        concert.save
        last_row = Database.execute("SELECT * FROM concerts")[0]
        database_id = last_row['id']
        assert_equal database_id, concert.id
      end
    end
    describe "if we update an existing concert" do
      let(:concert){Concert.new({:artist=>"Wilco", :concert_date=>"2000-02-02", :venue_id=>"1", :rating=>"10"})}
      it "changes the existing concert's attribute and persists the existing concert's id" do
        concert.save
        found_concert = Concert.find(concert.id)
        found_concert.artist = "not Wilco"
        found_concert.save
        updated_concert = Concert.find(concert.id)
        assert_equal updated_concert.artist, "not Wilco"
        assert_equal updated_concert.id, concert.id
        assert_equal 1, Concert.count
      end
    end
  end

end
