# frozen_string_literal: true

module TextExclude
  # FileManager handles very basic I/O.
  # At this time it has only limited support for Linux.
  # Future work will most certainly include support for windows.
  # There need to be other support like FTP as well.
  class FileManager
    # Basic initialization
    def initialization
      @current_directory = ''
    end

    # Get initial file structure for the directory on this level
    # and what is id under it.
    def file_get_initialization(structure = ENV['HOME'])  # linux specific for now
      @file_information = {}                              # {"/directory"=>["file"], "/directory/directory"=>["file", "file"]
      files = []
      directory = ''
      directories = []
      things = structure.split('/')
      things.each do |thing|
        if thing == ''
          directories.push('/root')
        else
          directory = "#{directory}/#{thing}"
          @current_directory = directory
          directories.push(directory.to_s) if File.directory?(directory.to_s)
        end
      end
      directories
    end

    # List out the files for this directory.
    def file_get_files(directories)
      directory = ''
      files = []
      directories.each do |directory|
        next if directory == '/root'
        Dir.chdir(directory.to_s)
        Dir.foreach(directory.to_s) do |d|
          files.push(d) unless d == '.' || d == '..'
        end
        @file_information.store(directory, files)
        files = []
      end
      @file_information
    end

    # Dig deeper down into the directory information.
    def file_get_more_information(directory)
      @files = []
      @file_information = {} # {"/directory"=>["file"], "/directory/directory"=>["file", "file"]
      unless @current_directory == ''
        directory = "#{@current_directory}/#{directory}"
      end
      @current_directory = directory
      Dir.chdir(directory.to_s)
      Dir.foreach(directory.to_s) do |d|
        @files.push(d) unless d == '.' || d == '..'
      end
      @file_information.store(directory, @files)
      @files = []
      @file_information
    end

    # Standard file open.
    def file_open(file, mode = 'r')
      handle = File.open(file.to_s, mode.to_s)
      text_lines = {}
      file_in = handle.readlines
      file_in.each_with_index do |line, line_num|
        text_lines[line_num] = line.chomp
      end
      text_lines
    end

    # Writes any given file
    def file_write(file, text_area, mode = 'w')
      if File.writable?(file)
        handle = File.open(file.to_s, mode.to_s)
        text_area.each_pair do |_index, text_paired|
          handle.write("#{text_paired[1]}\n") if text_paired[0] == 'text'
        end
      else
        puts 'Not authorized to write in the folder'
        false
      end
      #    file_close(file)
    end

    # Standard file close.
    def file_close(_file)
      @handle.close
    end

    # Keeps the current working file available
    # Currently file history is only one deep
    def file_history_push(file)
      file_history = $file_history.to_h
      file_history.each_pair do |index, file_name|
        next unless file_name == ''
        file_name = file
        $file_history[index.to_s] = file_name.to_s
        break
      end
    end

    # Not in use
    # Needs to be tested
    def file_history_pop(_file)
      file_history = $file_history.to_h
      current_history = file_history.pop
      file_history.each_pair do |index, file_name|
        if file_name == current_history
          $file_history.delete_field(index.to_s)
          break
        end
      end
    end

    # lots of possible uses for this but right now current is
    # returned for all file requests
    def file_history_current
      file_history = $file_history.to_h
      file_history.each_pair do |_index, file_name|
        return file_name unless file_name == ''
      end
    end

    # A file directory has been presented and a selection made.
    # * Now it is necessary to determine if the selection is a file or another directory.
    # * This method runs recursively until a file is the selection.
    # * It then records the file in history and returns the file name.
    def file_directory(selection)
      while File.directory?(selection)
        @file_information = file_get_more_information(selection)
        selection = file_selection(@file_information)
        break unless File.directory?(selection)
      end

      if File.directory?(selection)
        @file_information.each do |directory, files|
          files.each do |file|
            @file = "#{directory}/#{file}" if file == selection
          end
        end
      else
        @file = selection
      end

      file_history_push(@file)                     # store it
      text_lines = file_open(@file, 'r')     # open for read
    end

    # Present the files in this directory for selection.
    def file_selection(file_information)
      key        = 'root'                          # linux support only for now
      file_break = ''                              # save for "break"
      index      = 0 # for user selection
      number    = 0 # for selection from table
      ui        = {}

      # build display for user selection
      file_information.each_pair do |directory, files|
        next unless files.length > 1
        ui.store(index, directory) # the internal UI
        puts "Now in directory: #{directory}"
        files.each do |file|
          next if file.start_with?('.')
          if File.directory?(file)
            puts "#{index} #{file}"
          else
            puts "  #{index} #{file}"
          end

          ui.store(index, file)
          index += 1
        end
      end

      if $mode == 'test'
        file = ARGF.readline
        @selection = file.chomp!
        number = selection.chomp!.to_i
        file_name = ui[number] # get selection from UI table
      else # global test switch
        ARGF.each_line do |selection|
          number = selection.chomp!.to_i
          break if (0..index).cover?(number.to_i) # index reused from above
        end
        file_name = ui[number] # get selection from UI table
      end
    end
  end
end
