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

  end

end
