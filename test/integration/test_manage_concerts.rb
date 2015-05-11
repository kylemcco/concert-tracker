require_relative '../test_helper'

class TestEditConcert < MiniTest::Test

  def test_select_manage_concerts
    shell_output = ""
    expected = ""
    IO.popen('./concert-tracker manage', 'r+') do |pipe|
      pipe.puts "2"
      pipe.close_write
      shell_output = pipe.read
    end
    expected << <<-EOS
1. Add a concert
2. Manage concerts
3. View statistics
4. Exit
EOS
    expected << "No concerts to edit. Add concerts.\n"

    assert_equal expected, shell_output
  end

end
