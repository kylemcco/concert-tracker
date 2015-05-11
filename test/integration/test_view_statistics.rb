require_relative '../test_helper'

class TestViewStatistics < MiniTest::Test

  def test_select_view_statistics
    shell_output = ""
    expected = ""
    IO.popen('./concert-tracker manage', 'r+') do |pipe|
      pipe.puts "3"
      pipe.close_write
      shell_output = pipe.read
    end
    expected << <<-EOS
1. Add a concert
2. Manage concerts
3. View statistics
4. Exit
EOS
    expected << "No concert data available. Add concerts.\n"

    assert_equal expected, shell_output
  end

end
