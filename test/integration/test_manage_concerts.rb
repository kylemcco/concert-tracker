require_relative '../test_helper'

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
# 2. List alphabetically by artist
# &gt; 2
# 1. Animal Collective
# 2. My Morning Jacket
# 3. St. Vincent
# 4. Wilco
# &gt; 4
# You saw Wilco play The Ryman in Nashville, TN on 2011-10-02. You gave this show a 10/10.
# 1. Edit artist
# 2. Edit venue
# 3. Edit rating
# 4. Delete concert
# 5. Exit
# &gt; 3
# Rate your experience on a scale of one to ten (1-10)
# &gt; 7
# Concert saved.
# </pre></code>
#
# Acceptance criteria:
# 1. Program prints confirmation that concert was edited
# 2. Concert information is edited in the database
# 3. After being edited, the new concert data will be visible via "View statistics" once that feature is implemented
# 4. After the edit the user is taken back to the main menu

def user_input(*args)
  shell_output = ""
  IO.popen('./concert_tracker', 'r+') do |pipe|
    pipe.puts "2" ## selects 2: Manage concerts
    args.each do |arg| ## processes user inputs
      pipe.puts arg
    end
    pipe.close_write
    shell_output = pipe.read
    shell_output
  end
end

describe "managing a concert" do
  before do
    Concert.new({:artist=>"St. Vincent",:concert_date=>"2010-10-02",:venue_id=>"2",:rating=>"8"}).save
    Concert.new({:artist=>"Wilco",:concert_date=>"2011-10-02",:venue_id=>"1",:rating=>"10"}).save
  end
  # 
  # describe "when a user updates a concert rating" do
  #   it "should update the concert rating in the database" do
  #     user_input("2","1", "3", "7") #List concerts alpha by artist, select Wilco, Edit rating, change to 7
  #     concert = Concert.find(1)
  #     assert_equal 7, concert.rating
  #   end
  # end

end
