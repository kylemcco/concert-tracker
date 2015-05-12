require_relative '../test_helper'

# ### Manage an existing concert
# In order to edit or delete concerts I want to manage existing concert entries.
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
# 1. Animal Collective
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
# &gt; 5
# Rate your experience on a scale of one to ten (1-10)
# &gt; 7
# Concert saved.
# You saw Wilco play The Ryman in Nashville, TN on 10/02/2011. Nick Lowe opened. You gave this show a 6/10.
# 1. Edit headliner
# 2. Edit opening act(s)
# 3. Edit venue
# 4. Edit city/state
# 5. Edit rating
# 6. Exit
# &gt; 6
# </pre></code>
#
# Acceptance criteria:
# 1. Program prints confirmation that concert was edited
# 2. Concert information is edited in the database
# 3. After being edited, the new concert data will be visible via "View statistics" once that feature is implemented
# 4. After the edit the user is taken back to the main menu  

class TestManageConcert < MiniTest::Test

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
