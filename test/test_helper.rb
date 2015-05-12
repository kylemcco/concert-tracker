require 'rubygems'
require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/reporters'

reporter_options = {color: true}
Minitest::Reporters::use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

def main_menu
<<EOS
1. Add a concert
2. Manage concerts
3. View statistics
4. Exit
EOS
end
