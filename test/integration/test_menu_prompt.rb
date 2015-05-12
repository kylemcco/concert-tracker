require_relative '../test_helper'

class TestMenuPromptWithInitialArgument < MiniTest::Test

  def test_minimum_arguments_required
    shell_output = ""
    expected = ""
    IO.popen('./concert-tracker', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    expected = "[Help] Run as: ./concert-tracker manage\n"
    assert_equal expected, shell_output
  end

  def test_manage_argument_not_given
    shell_output = ""
    expected = ""
    IO.popen('./concert-tracker blah', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    expected = "[Help] Run as: ./concert-tracker manage\n"
    assert_equal expected, shell_output
  end

  def test_manage_argument_given
    shell_output = ""
    expected = ""
    IO.popen('./concert-tracker manage', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    expected << main_menu
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
    expected << main_menu
    expected << "Welp, seeya later\n"
    assert_equal expected, shell_output
  end

  def test_no_concerts_found
    shell_output = ""
    expected = ""
    IO.popen('./concert-tracker manage', 'r+') do |pipe|
      pipe.puts "3"
      pipe.close_write
      shell_output = pipe.read
    end
    expected << main_menu
    expected << "No data available. Add concerts.\n"
    assert_equal expected, shell_output
  end

end
