require_relative "../test_helper"

describe ConcertsController do

  describe ".index" do
    let(:controller) {ConcertsController.new}

    it "should say no concerts found when empty" do
      actual_output = controller.index
      expected_output = "No concerts found. Add a concert.\n"
      assert_equal expected_output, actual_output
    end
  end

  describe ".add" do
    let(:controller) {ConcertsController.new}

    it "should add a concert" do
      controller.add({"artist"=>"Wilco", "concert_date"=>"02/02/2000", "venue"=>"The Ryman", "location"=>"Nashville, TN", "rating"=>"10"})
      assert_equal 1, Concert.count
    end
  end

end
