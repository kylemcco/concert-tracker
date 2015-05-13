require_relative '../test_helper'

# ### Viewing statistics based on existing concert data
# In order to view my concert-going habits and retrieve memories I want to view useful information derived from existing concert entries.
#
# Usage example:
# <pre><code>
# &gt; ./concert_tracker
# 1. Add a concert
# 2. Manage concerts
# 3. View statistics
# 4. Exit
# &gt; 3
# 1. General stats
# 2. Artist stats
# 3. Venue stats
# 4. Year stats
# 5. Exit
# &gt; 1
# You have tracked 32 concerts. You've seen Andrew Bird play more than any other artist. Your most visited venue is The Ryman in Nashville, TN.
# 1. General stats
# 2. Artist stats
# 3. Venue stats
# 4. Year stats
# 5. Exit
# &gt; 2
# Select artist:
# 1. Andrew Bird
# 2. My Morning Jacket
# 3. St. Vincent
# 4. Wilco
# &gt; 1
# You have seen Andrew Bird 5 times. Based on your concert ratings Andew Bird ranks &#35;2 of all the artists you've seen.
# </pre></code>
#
# Acceptance criteria:
# 1. Program prints statistics based on database data
# 2. After viewing statistics the user is taken back to the main menu


class TestViewStatistics < MiniTest::Test

  def test_viewing_statistics_no_concerts
    shell_output = ""
    expected_output = ""
    IO.popen('./concert-tracker manage', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts "3"
      expected_output << "No concerts found. Add a concert.\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_viewing_statistics_multiple_concerts
    add_concert("Wilco")
    add_concert("Andrew Bird")
    shell_output = ""
    expected_output = ""
    IO.popen('./concert-tracker manage', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts "3" # View statistics
      expected_output << "1. Andrew Bird\n"
      expected_output << "2. Wilco\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

end
