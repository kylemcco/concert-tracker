require_relative '../test_helper'

class AddingANewConcertTest < Minitest::Test
  def test_happy_path_adding_a_concert
    shell_output = ""
    expected_output = main_menu
    test_artist = "Wilco"
    test_concert_date = "02/02/2000"
    test_venue = "The Ryman"
    test_location = "Nashville, TN"
    test_rating = "10"
    IO.popen('./concert_tracker', 'r+') do |pipe|
      pipe.puts "1"
      expected_output << "Answer the following questions about the concert:\n"
      expected_output << "Who was the artist?\n"
      pipe.puts test_artist
      expected_output << "When was the concert? (mm/dd/yyyy)\n"
      pipe.puts test_concert_date
      expected_output << "What was the name of the venue?\n"
      pipe.puts test_venue
      expected_output << "Where is the venue located? (City, ST)\n"
      pipe.puts test_location
      expected_output << "Rate your experience on a scale of 1-10\n"
      pipe.puts test_rating
      expected_output << "Cool! You saw #{test_artist} play #{test_venue} in #{test_location} on #{test_concert_date}. You gave this show a #{test_rating}. Is that correct? (y/n)\n"
      pipe.puts "y"
      expected_output << "Concert saved\n"
      shell_output = pipe.read
      pipe.close_write
      pipe.close_read
    end
    assert_equal expected_output, shell_output
  end

end
