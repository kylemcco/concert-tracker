require_relative '../test_helper'

class TestAddConcert < MiniTest::Test

  def test_select_add_concert
    shell_output = ""
    expected = ""
    IO.popen('./concert-tracker manage', 'r+') do |pipe|
      pipe.puts "1"
      pipe.close_write
      shell_output = pipe.read
    end
    expected << <<-EOS
1. Add a concert
2. Manage concerts
3. View statistics
4. Exit
EOS
    expected << "Answer the following questions about the concert:\n"
    expected << "Who was the headlining act?\n"

    assert_equal expected, shell_output
  end

end
