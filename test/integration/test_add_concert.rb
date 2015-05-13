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
# Answer the following questions about the concert:
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
#
# Acceptance criteria:
# 1. Program prints confirmation that concert was added
# 2. Concert is added to the database
# 3. After being added, the concert will be visible via "View statistics" once that feature is implemented
# 4. After the addition the user is taken back to the main menu

class TestAddConcert < MiniTest::Test

  def test_select_add_concert
    shell_output = ""
    expected = ""
    IO.popen('./concert_tracker', 'r+') do |pipe|
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
