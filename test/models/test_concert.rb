require_relative '../test_helper'

describe Concert do
  describe "#all" do
    describe "if there are no concerts in the database" do
      it "should return an empty array" do
        assert_equal [], Concert.all
      end
    end
    describe "if there are concerts" do
      before do
        add_concert({"artist"=>"Wilco", "concert_date"=>"02/02/2000", "venue"=>"The Ryman", "location"=>"Nashville, TN", "rating"=>"10"})
        add_concert({"artist"=>"Andrew Bird", "concert_date"=>"02/02/2000", "venue"=>"The Ryman", "location"=>"Nashville, TN", "rating"=>"10"})
        add_concert({"artist"=>"Neil Young", "concert_date"=>"02/02/2000", "venue"=>"The Ryman", "location"=>"Nashville, TN", "rating"=>"10"})
      end
      it "should return the concerts in alphabetical order" do
        expected = ["Andrew Bird", "Neil Young", "Wilco"]
        actual = Concert.all.map{ |concert| concert.artist }
        assert_equal expected, actual
      end
    end
  end

  describe "#count" do
    describe "if there are no concerts in the database" do
      it "should return 0" do
        assert_equal 0, Concert.count
      end
    end
    describe "if there are concerts" do
      before do
        add_concert({"artist"=>"Wilco", "concert_date"=>"02/02/2000", "venue"=>"The Ryman", "location"=>"Nashville, TN", "rating"=>"10"})
        add_concert({"artist"=>"Andrew Bird", "concert_date"=>"02/02/2000", "venue"=>"The Ryman", "location"=>"Nashville, TN", "rating"=>"10"})
        add_concert({"artist"=>"Neil Young", "concert_date"=>"02/02/2000", "venue"=>"The Ryman", "location"=>"Nashville, TN", "rating"=>"10"})
      end
      it "should return the correct count" do
        assert_equal 3, Concert.count
      end
    end
  end

  describe ".save" do
    describe "if we want to save a concert to the database" do
      before do
        concert = Concert.new({"artist"=>"Wilco", "concert_date"=>"02/02/2000", "venue"=>"The Ryman", "location"=>"Nashville, TN", "rating"=>"10"})
        concert.save
      end
      it "should add a concert" do
        assert_equal 1, Concert.count
      end
    end
  end

end
