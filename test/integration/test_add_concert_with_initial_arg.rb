require_relative '../test_helper'

# ### Adding a concert
# In order to catalog concerts attended I want to add concert data.
#
# Usage example:
# <pre><code>
# &gt; ./concert_tracker
# 1. Add a concert
# 2. Manage concerts
# 3. View statistics
# 4. Exit
# &gt; 1
# Who was the headlining act?
# &gt; Wilco
# Do you want to add a genre? (y/n)
# &gt; y
# 1. Rock
# 2. Folk
# 3. Jazz
# 4. Other (add a genre)
# &gt; 1
# Were there any noteworthy openers? (y/n)
# &gt; y
# List the opening act(s), seperated by commas (KISS,Meatloaf)
# &gt; Nick Lowe
# Do you want to add a genre for Nick Lowe?
# &gt; n
# When was the concert? (mm/dd/yyyy)
# &gt; 10/02/2011
# What was the name of the venue?
# &gt; The Ryman
# Where is the venue located? (city, ST)
# &gt; Nashville, TN
# Rate your experience on a scale of one to ten (1-10)
# &gt; 10
# Cool! You saw Wilco play The Ryman in Nashville, TN on 10/02/2011. Nick Lowe opened. You gave this show a 10/10. Is that correct? (y/n)
# &gt; y
# Concert saved.
# </pre></code>

class TestAddingConcertWithInitialArgument < MiniTest::Test

  def test_minimum_arguments_required
    shell_output = ""
    expected = ""
    IO.popen('./concert-tracker', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    expected = "[Help] Run as: ./concert-tracker manage"
    assert_equal expected, shell_output
  end

  def test_manage_argument_not_given
    shell_output = ""
    expected = ""
    IO.popen('./concert-tracker blah', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    expected = "[Help] Run as: ./concert-tracker manage"
    assert_equal expected, shell_output
  end

  def test_manage_argument_given
    shell_output = ""
    expected = ""
    IO.popen('./concert-tracker manage', 'r+') do |pipe|
      pipe.puts ""
      pipe.close_write
      shell_output = pipe.read
    end
    expected = <<EOS
1. Add a concert
2. Manage concerts
3. View statistics
4. Exit
EOS
    assert_equal expected, shell_output
  end

  def test_program_can_exit
    shell_output = ""
    expected = ""
    IO.popen('./concert-tracker manage', 'r+') do |pipe|
      pipe.puts "4"
      pipe.close_write
      shell_output = pipe.read
    end
    expected = <<EOS
1. Add a concert
2. Manage concerts
3. View statistics
4. Exit
EOS
    expected << "Welp, seeya later"
    assert_equal expected, shell_output
  end

end
