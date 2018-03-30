# frozen_string_literal: true

require 'test/unit/testcase'
require 'test/unit/autorunner'
require 'text_exclude/user_interface'
require 'text_exclude/text_processor'
require 'text_exclude/file_manager'
require 'ostruct'

# TestTextExclude implements the basic unit tests. Comprehensive units
# tests are required actual validation.
# However specifying exactly how all these functions are to work is not
# plausible when designing for  a Command Line and Log interface.
class TestTextExclude < Test::Unit::TestCase
  $mode = 'test'

  # Initial setup
  def setup
    @user_interface = TextExclude::UserInterface.new
    @text_processor = TextExclude::TextProcessor.new
    @file_manager  = TextExclude::FileManager.new

    # set up control structure for file names
    $file_history  = OpenStruct.new(file01: '', file02: '', file03: '',
                                    file04: '', file05: '', file06: '',
                                    file07: '', file08: '', file09: '')

    # set up control structure for search strings
    $search_history = OpenStruct.new(search01: '', search02: '', search03: '',
                                     search04: '', search05: '', search06: '',
                                     search07: '', search08: '', search09: '')
  end

  # Test of 1. Include additional lines in TextProcessor::text_include"
  def test_text_exclude_0100
    puts "\ntest_text_exclude_0100 Test of 1. Include additional lines in TextProcessor::text_include"
    puts "test_text_iexclude_0100 Processing /home/brad/runner/control0100 as Stdin\n"
    ARGV.push('/home/brad/runner/control0100')
    file_name  = @user_interface.send(:user_file_read)
    text_lines = @file_manager.send(:file_directory, '/home/brad/runner/testdata')
    pattern    = @user_interface.send(:user_pattern)
    puts "test_text_exclude_0100 Test pattern is: #{pattern}\n"
    assert(pattern == '4', ":user_pattern in test_text_exclude_ got #{pattern} so something about control0100")
    text_area = @text_processor.send(:text_include, text_lines)
    @user_interface.send(:user_display, text_area)
    #            text_area.each { |ta| p ta }
    assert(text_area[3] == ['before', 3], 'Failed 0100 UserInterface::text_include')
    assert(text_area[4] == ['text', ' 4 m n o p q mnopq line0'], 'Failed 0110 UserInterface::text_include')
    assert(text_area[5] == ['fill', ''], 'Failed 0120 UserInterface::text_include')
    assert(text_area[39] == ['before', 5], 'Failed 0130 UserInterface::text_include')
    assert(text_area[40] == ['text', '40 r s t u v rstuv line4 fourty'], 'Failed 0140 UserInterface::text_include')
    selection = @user_interface.send(:user_prompt_options, text_area)
    assert(selection == '1', ":user_prompt_options in test_text_exclude_ got #{selection} so something about control0100")
    pattern = @user_interface.send(:user_pattern) if selection == '1'
    assert(pattern == 'abc', ":user_pattern in test_text_exclude_ got #{pattern} so something about control0100")
    text_area = @text_processor.send(:text_include, text_lines) if selection == '1'
    @user_interface.send(:user_display, text_area) if ('1'..'5').cover?(selection)
    #            text_area.each { |ta| p ta }
    assert(text_area[1] == ['text', ' 1 a b c d e abcde line0 zero start'], 'Failed 0150 TextProcessor::text_include')
    assert(text_area[3] == ['before', 2], 'Failed 0160 TextProcessor::text_include')
    assert(text_area[4] == ['text', ' 4 m n o p q mnopq line0'], 'Failed 0170 TextProcessor::text_include')
    assert(text_area[33] == ['before', 2], 'Failed 0180 TextProcessor::text_include')
    assert(text_area[40] == ['text', '40 r s t u v rstuv line4 fourty'], 'Failed 0190 TextProcessor::text_include')
    puts "\ntest_text_exclude_0100 Test of 1. Include additional lines in TextProcessor::text_include completed"
  end

  # Test of 2. Exclude additional lines TextProcessor::text_exclude"
  def test_text_exclude_0200
    puts "\ntest_text_exclude_0200 Test of 2. Exclude additional lines TextProcessor::text_exclude"
    puts "test_text_exclude_0200 Processing /home/brad/runner/control0200 as Stdin\n"
    ARGV.push('/home/brad/runner/control0200')
    file_name  = @user_interface.send(:user_file_read)
    text_lines = @file_manager.send(:file_directory, '/home/brad/runner/testdata')
    pattern    = @user_interface.send(:user_pattern)
    puts "test_text_exclude_0200 Test pattern is: #{pattern}"
    assert(pattern == 'abc', ":user_pattern in test_text_exclude_ got #{pattern} so something about the test commands changed")
    text_area = @text_processor.send(:text_include, text_lines)
    @user_interface.send(:user_display, text_area)
    #            text_area.each { |ta| p ta }
    assert(text_area[1] == ['text', ' 1 a b c d e abcde line0 zero start'], 'Failed 0200 TextProcessor::text_include')
    assert(text_area[5] == ['before', 4], 'Failed 0210 TextProcessor::text_include')
    assert(text_area[36] == ['text', '36 a b c d e abcde zayin'], 'Failed 0220 TextProcessor::text_include')
    assert(text_area[40] == ['after', 4], 'Failed 0230 TextProcessor::text_include')
    selection = @user_interface.send(:user_prompt_options, text_area)
    assert(selection == '2', ":user_prompt_options in test_text_exclude_ got #{selection} so something about control0200")
    pattern = @user_interface.send(:user_pattern) if selection == '2'
    assert(pattern == 'zayin', ":user_pattern in test_text_exclude_ got #{pattern} so something about control0200")
    text_area = @text_processor.send(:text_exclude, text_area) if selection == '2'
    #            text_area.each { |ta| p ta }
    #   text_area  = @text_processor.send(:text_include, text_area)  if selection == "2"
    @user_interface.send(:user_display, text_area) if ('1'..'5').cover?(selection)
    assert(text_area[0] == ['text', 'Not yet implemented'], 'Failed 0240 TextProcessor::text_exclude')
    puts "\ntest_text_exclude_0200 Test of 2. Exclude additional lines TextProcessor::text_exclude completed"
  end

  # Test of 3. Delete all included text TextProcessor::text_delete_in"
  def test_text_exclude_0300
    puts "\ntest_text_exclude_0300 Test of 3. Delete all included text TextProcessor::text_delete_in"
    puts "\ntest_text_exclude_0300 Processing /home/brad/runner/control0300 as Stdin\n"
    ARGV.push('/home/brad/runner/control0300')
    file_name  = @user_interface.send(:user_file_read)
    text_lines = @file_manager.send(:file_directory, '/home/brad/runner/testdata')
    pattern    = @user_interface.send(:user_pattern)
    puts "test_text_exclude_0300 Test pattern is: #{pattern}"
    assert(pattern == 'hijkl line1', ":user_pattern in test_text_exclude_ got #{pattern} so something about the test commands changed")
    text_area = @text_processor.send(:text_include, text_lines)
    @user_interface.send(:user_display, text_area)
    #            text_area.each { |ta| p ta }
    assert(text_area[12] == ['before', 12], 'Failed 0300 TextProcessor::text_include')
    assert(text_area[13] == ['text', '13 h i j k l hijkl line1'], 'Failed 0310 TextProcessor::text_include')
    assert(text_area[17] == ['before', 4], 'Failed 0320 TextProcessor::text_include')
    assert(text_area[18] == ['text', '18 h i j k l hijkl line1'], 'Failed 0330 TextProcessor::text_include')
    assert(text_area[40] == ['after', 22], 'Failed 0340 TextProcessor::text_include')
    selection = @user_interface.send(:user_prompt_options, text_area)
    assert(selection == '3', ":user_prompt_options in test_text_exclude_ got #{selection} so something about control0300")
    text_area = @text_processor.send(:text_delete_in, text_lines) if selection == '3'
    @user_interface.send(:user_display, text_area) if ('1'..'5').cover?(selection)
    #            text_area.each { |ta| p ta }
    assert(text_area[1]  == ['text', ' 1 a b c d e abcde line0 zero start'], 'Failed 0350 TextProcessor::text_include')
    assert(text_area[13] == ['text', '14 m n o p q mnopq line1'], 'Failed 0360 TextProcessor::text_include')
    assert(text_area[17] == ['text', '19 m n o p q mnopq line1'], 'Failed 0370 TextProcessor::text_include')
    assert(text_area[38] == ['text', '40 r s t u v rstuv line4 fourty'], 'Failed 0380 TextProcessor::text_include')
    puts "\ntest_text_exclude_0300 Test of 3. Delete all included text TextProcessor::text_delete_in completed"
  end

  # Test of 4. Delete all excluded text TextProcessor::text_delete_ex"
  def test_text_exclude_0400
    puts "\ntest_text_exclude_0400 Test of 4. Delete all excluded text TextProcessor::text_delete_ex"
    puts "\ntest_text_exclude_0400 Processing /home/brad/runner/control0400 as Stdin\n"
    ARGV.push('/home/brad/runner/control0400')
    file_name  = @user_interface.send(:user_file_read)
    text_lines = @file_manager.send(:file_directory, '/home/brad/runner/testdata')
    pattern    = @user_interface.send(:user_pattern)
    puts "test_text_exclude_0400 Test pattern is: #{pattern}"
    assert(pattern == 't', ":user_pattern in test_text_exclude_ got #{pattern} so something about the test commands changed")
    text_area = @text_processor.send(:text_include, text_lines)
    @user_interface.send(:user_display, text_area)
    #            text_area.each { |ta| p ta }
    assert(text_area[19] == ['before', 4], 'Failed 0400 UserInterface::text_include')
    assert(text_area[20] == ['text', '20 r s t u v rstuv extra twenty'], 'Failed 0410 UserInterface::text_include')
    selection = @user_interface.send(:user_prompt_options, text_area)
    assert(selection == '4', ":user_prompt_options in test_text_exclude_ got #{selection} so something about control0300")
    text_area = @text_processor.send(:text_delete_ex) if selection == '4'
    @user_interface.send(:user_display, text_area) if ('1'..'5').cover?(selection)
    #            text_area.each { |ta| p ta }
    assert(text_area[1]  == ['text', ' 1 a b c d e abcde line0 zero start'], 'Failed 0420 TextProcessor::text_delete_ex')
    assert(text_area[5]  == ['text', ' 5 r s t u v rstuv line0'], 'Failed 0420 TextProcessor::text_delete_ex')
    assert_no_match(/"before"/, 'text_area[9]', 'Failed 0430 TextProcessor::text_delete_ex')
    assert(text_area[10] == ['text', '10 r s t u v rstuv line0 ten'], 'Failed 0440 TextProcessor::text_delete_ex')
    assert_no_match(/"fill"/, 'text_area[33]', 'Failed 0450 TextProcessor::text_delete_ex')
    puts "\ntest_text_exclude_0400 Test of 4. Delete all included text TextProcessor::text_delete_ex completed"
  end

  # Test of 1. Include additional lines with range in TextProcessor::text_mixer_include"
  def test_text_exclude_r100
    puts "\ntest_text_exclude_r100 Test of 1. Include additional lines with range in TextProcessor::text_mixer_include"
    puts "test_text_exclude_r100 Processing /home/brad/runner/controlr100 as Stdin\n"
    ARGV.push('/home/brad/runner/controlr100')
    file_name  = @user_interface.send(:user_file_read)
    text_lines = @file_manager.send(:file_directory, '/home/brad/runner/testdata')
    pattern    = @user_interface.send(:user_pattern)
    puts "test_text_exclude_r100 Test pattern is: #{pattern}\n"
    assert(pattern == 'rs', ":user_pattern in test_text_exclude got #{pattern} so something about controlr100")
    text_area = @text_processor.send(:text_include, text_lines)
    @user_interface.send(:user_display, text_area)
    #            text_area.each { |ta| p ta }
    assert(text_area[4] == ['before', 4], 'Failed r100 UserInterface::text_include')
    assert(text_area[5] == ['text', ' 5 r s t u v rstuv line0'], 'Failed r110 UserInterface::text_include')
    assert(text_area[39] == ['before', 4], 'Failed r120 UserInterface::text_include')
    assert(text_area[40] == ['text', '40 r s t u v rstuv line4 fourty'], 'Failed r130 UserInterface::text_include')
    selection = @user_interface.send(:user_prompt_options, text_area)
    assert(selection == '5', ":user_prompt_options in test_text_exclude_ got #{selection} so something about controlr100")
    arguments  = @user_interface.send(:user_prompt_ranges, text_area, text_lines) if selection    == '5'
    #                 assert(arguments == "[\"1\",\"5\",\"12\"]", ":user_prompt_options in test_text_exclude_r100 got #{arguments} so something about controlr100")
    parameters = @text_processor.send(:text_mixer, text_area, arguments)          if selection    == '5'
    #                 assert(parameters == "[\"1\",\"5\",\"12\"]", ":text_mixer in test_text_exclude_r100 got #{parameters} so something about controlr100")
    pattern    = @user_interface.send(:user_pattern)                              if selection == '5'
    assert(pattern == 'abc', ":user_pattern in test_text_exclude got #{pattern} so something about controlr100")
    text_area = @text_processor.send(:text_include, text_lines)
    @user_interface.send(:user_display, text_area)
    #            text_area.each { |ta| p ta }
    assert(text_area[1] == ['text', ' 1 a b c d e abcde line0 zero start'], 'Failed r140 TextProcessor::text_include')
    assert(text_area[4] == ['before', 3], 'Failed r160 TextProcessor::text_include')
    assert(text_area[5] == ['text', ' 5 r s t u v rstuv line0'], 'Failed r170 TextProcessor::text_include')
    assert(text_area[39] == ['before', 3], 'Failed r180 TextProcessor::text_include')
    assert(text_area[40] == ['text', '40 r s t u v rstuv line4 fourty'], 'Failed r190 TextProcessor::text_include')
    puts "\ntest_text_exclude_r100 Test of 1. Include additional lines in TextProcessor::text_mixer_include completed"
  end
end
