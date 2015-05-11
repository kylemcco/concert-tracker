require_relative '../test_helper'

class TestDeleteConcert < MiniTest::Test

  def test_select_delete_concert
    shell_output = ""
    expected = ""
    IO.popen('./concert-tracker manage', 'r+') do |pipe|
      pipe.puts "2"
      pipe.puts "6"
      pipe.close_write
      shell_output = pipe.read
    end
    expected << <<-EOS
1. Add a concert
2. Manage concerts
3. View statistics
4. Exit
EOS
    expected << <<-EOS
1. Edit headliner
2. Edit opening act(s)
3. Edit venue
4. Edit city/state
5. Edit rating
6. Delete concert
7. Exit
EOS
    expected << "No concert data available. Add concerts.\n"
    assert_equal expected, shell_output
  end

end
