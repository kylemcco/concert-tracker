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
        add_concert("Wilco")
        add_concert("Andrew Bird")
        add_concert("Neil Young")
      end
      it "should return the concerts in alphabetical order" do
        expected = ["Andrew Bird", "Neil Young", "Wilco"]
        actual = Concert.all.map{ |concert| concert.name }
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
        add_concert("Wilco")
        add_concert("Andrew Bird")
        add_concert("Neil Young")
      end
      it "should return the correct count" do
        assert_equal 3, Concert.count
      end
    end
  end
end
