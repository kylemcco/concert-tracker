require_relative '../test_helper'

class TestConcertTrackerIntegration < MiniTest::Test

  def test_no_input
    shell_output = ""
    expected = ""
    IO.popen('./concert-tracker', 'r+') do |pipe|
      pipe.puts ""
      pipe.close_write
      shell_output = pipe.read
    end
    expected << "I'm sorry, I couldn't understand that."
    assert_equal expected, shell_output
  end

end
