# require_relative '../test_helper'
#
# def user_input(*args)
#   shell_output = ""
#   IO.popen('./concert_tracker', 'r+') do |pipe|
#     pipe.puts "1" ## selects 1: Add concert
#     args.each do |arg| ## processes user inputs
#       pipe.puts arg
#     end
#     pipe.close_write
#     shell_output = pipe.read
#     shell_output
#   end
# end
#
# describe Concert do
#
#   describe ".validate_artist" do
#     it "should ask for artist input again if user inputs an empty string" do
#       shell_output = user_input("")
#       assert_includes shell_output, "Headliner cannot be empty"
#     end
#     it "should not ask for artist input again if user inputs an empty string" do
#       shell_output = user_input("Wilco")
#       refute_includes shell_output, "Headliner cannot be empty"
#     end
#   end
#
#   describe ".validate_date" do
#     it "should ask for date input again if user inputs an empty string" do
#       shell_output = user_input("Wilco","")
#       assert_includes shell_output, "Invalid date. Enter date in MM/DD/YYYY format."
#     end
#     it "should ask for date input again if user inputs a incorrectly formatted date" do
#       shell_output = user_input("Wilco","August 6 2012")
#       assert_includes shell_output, "Invalid date. Enter date in MM/DD/YYYY format."
#     end
#     it "should not ask for date input again if user inputs a correctly formatted date" do
#       shell_output = user_input("Wilco", "02/02/2014")
#       refute_includes shell_output, "Invalid date. Enter date in MM/DD/YYYY format."
#     end
#   end
#
# end
#
# describe Venue do
#
#   describe ".validate_name" do
#     it "should ask for venue input again if user inputs an empty string" do
#       shell_output = user_input("Wilco","02/02/2014","")
#       assert_includes shell_output, "Venue cannot be empty."
#     end
#     it "should not ask for venue input again if user inputs a correctly formatted venue" do
#       shell_output = user_input("Wilco","02/02/2014","The Ryman")
#       refute_includes shell_output, "Venue cannot be empty."
#     end
#   end
#
#   describe ".validate_location" do
#     it "should ask for location input again if user inputs an empty string" do
#       shell_output = user_input("Wilco","02/02/2014","The Ryman", "")
#       assert_includes shell_output, "Enter location in City, ST format (example: Nashville, TN)."
#     end
#     it "should ask for location input again if user inputs an incorrectly formatted location" do
#       shell_output = user_input("Wilco","02/02/2014","The Ryman", "Nashville TN")
#       assert_includes shell_output, "Enter location in City, ST format (example: Nashville, TN)."
#     end
#     it "should not ask for location input again if user inputs a correctly formatted location" do
#       shell_output = user_input("Wilco","02/02/2014","The Ryman", "Nashville, TN")
#       refute_includes shell_output, "Enter location in City, ST format (example: Nashville, TN)."
#     end
#   end
#
#   describe ".validate_rating" do
#     it "should ask for location input again if user inputs an empty string" do
#       shell_output = user_input("Wilco","02/02/2014","The Ryman", "Nashville, TN", "")
#       assert_includes shell_output, "Rating must be a number 1-10."
#     end
#     it "should ask for location input again if user inputs an incorrectly formatted rating" do
#       shell_output = user_input("Wilco","02/02/2014","The Ryman", "Nashville, TN", "12")
#       assert_includes shell_output, "Rating must be a number 1-10."
#     end
#     it "should not ask for location input again if user inputs a correctly formatted location" do
#       shell_output = user_input("Wilco","02/02/2014","The Ryman", "Nashville, TN", "10")
#       refute_includes shell_output, "Rating must be a number 1-10."
#     end
#   end
#
# end
