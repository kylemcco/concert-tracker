require_relative '../test_helper'

# ### Deleting a concert
# In order to remove incorrect entries or unmemorable concerts I want to delete existing concert entries.
#
# Usage example:
# <pre><code>
# &gt; ./concert_tracker
# 1. Add a concert
# 2. Manage concerts
# 3. View statistics
# 4. Exit
# &gt; 2
# 1. List chronologically
# 2. List alphabetically
# &gt; 2
# 1. Andrew Bird
# 2. My Morning Jacket
# 3. St. Vincent
# 4. Wilco
# &gt; 4
# You saw Wilco play The Ryman in Nashville, TN on 10/02/2011. Nick Lowe opened. You gave this show a 10/10.
# 1. Edit headliner
# 2. Edit opening act(s)
# 3. Edit venue
# 4. Edit city/state
# 5. Edit rating
# 6. Delete concert
# 7. Exit
# &gt; 6
# Are you sure you want to delete this concert? (y/n)
# &gt; y
# Concert deleted.
# </pre></code>
#
# Acceptance criteria:
# 1. Program prints confirmation that concert was deleted
# 2. Concert information is deleted from the database
# 3. After being deleted, the concert data will not be visible via "View statistics" once that feature is implemented
# 4. After the deletion the user is taken back to the main menu

class TestDeleteConcert < MiniTest::Test

  def test_select_delete_concert
    skip
    shell_output = ""
    expected = ""
    IO.popen('./concert_tracker', 'r+') do |pipe|
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
