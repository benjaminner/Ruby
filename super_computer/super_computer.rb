require 'json'
version = '0.4.0'
if not File.exist?('file')
  puts 'You need to set up the super_computer files and folders.'
  print 'Would you like to set up the folders and files?(y/n) '
  if gets.chomp == 'y'
    `touch super_computer;echo ruby \`pwd\`/super_computer.rb > super_computer;chmod +x super_computer;mkdir file;cd file;mkdir system;mkdir user`
  else
    exec('echo Please set up the super_computer files and folders to continue.')
  end
end
require 'open-uri'
dircur = "/file/user"
puts "super_computer.rb[#{version}]"
def beforespace(input)
  input[0...input.index(" ")]
end
def afterspace(input)
  input[input.index(" ")+1..input.length]
end
def updatefile(string)
  file = File.open(string, "w")
  $content.each do |line|
    file.write("#{line}")
  end
  file.close
end
loop do
  dirpath = ".#{dircur}/"
  print "#{dircur}> "
  input = gets.chomp

  break if input == "quit"
  break if input == ""

  if input.include? " "
    input_2 = afterspace(input)
    if beforespace(input) == "dir"
      if input_2.include?(" ")
        input_3 = afterspace(input_2)
        if beforespace(input_2) == "create"
          unless dircur == "/file" or dircur.include?("/file/system")
            `cd #{dirpath};mkdir #{input_3}`
            puts "Made directory `#{input_3}` under `#{dircur}`."
          else
            puts "DirectoryError: Cannot create or delete directories under `/file` or `/file/system`."
          end
        elsif beforespace(input_2) == "delete"
          unless dircur == "/file" or dircur.include?("/file/system")
            if File.exist?("#{dirpath}#{input_3}/")
              if `cd #{dirpath}#{input_3};ls` == ""
                `cd #{dirpath};rmdir #{input_3}`
                puts "Deleted directory `#{input_3}`."
              else
                puts `cd #{dirpath}#{input_3};ls`
                print "The files above will be deleted. Are you sure?(y/n) "
                if gets.chomp == 'y'
                  puts 'deleting...'
                  `cd #{dirpath}#{input_3};ls`.split("\n").each do |file|
                    File.delete("#{dirpath}#{input_3}/#{file}")
                  end
                  `rmdir #{dirpath}#{input_3}`
                end
              end
            else
              puts "DirectoryError: No directory `#{input_3}` under `#{dircur}`."
            end
          else
            puts "DirectoryError: Cannot create or delete directories under `/file` or `/file/system`."
          end
        elsif beforespace(input_2) == "sw"
          if File.exist?("#{dirpath}#{input_3}/")
            dircur += "/#{input_3}"
          else
            puts "DirectoryError: No directory `#{beforespace(input_2)}` under `#{dircur}`."
          end
        else
          puts "CommandError: No command '#{beforespace(input_2)}' for dir."
        end
      elsif input_2 == "parent"
        unless dircur == "/file"
          slashes = []
          x = 0
          dircur.each_char do |char|
            if char == "/"
              slashes.push(x)
            end
            x += 1
          end
          dircur = dircur[0...slashes[slashes.length-1]]
        else
          puts "DirectoryError: Cannot find parent directory of `/file`."
        end
      elsif input_2 == "list"
        puts `cd #{dirpath};ls`
      else
        puts "CommandError: No command '#{input_2}' for dir."
      end
    end
    if beforespace(input) == "file"
      if input_2.include? " "
        input_3 = afterspace(input_2)
        input_2 = beforespace(input_2)

        case input_2
        when "create"
          unless dircur == "/file" or dircur.include?("/file/system")
            `cd #{dirpath};touch #{input_3}`
            puts "Made file `#{input_3}` under `#{dircur}`."
          else
            puts "FileError: Cannot create, delete, or edit files under `/file` or `/file/system`."
          end
        when "delete"
          if File.exist?("#{dirpath}#{input_3}")
            unless dircur == "/file" or dircur.include?("/file/system")
              `cd #{dirpath};rm #{input_3}`
              puts "Deleted file `#{input_3}`."
            else
              puts "FileError: Cannot create, delete, or edit files under `/file` or `/file/system`."
            end
          else
            puts "FileError: No file `#{input_3}` under `#{dircur}`."
          end
        when "edit"
          if File.exist?("#{dirpath}#{input_3}")
            unless dircur == "/file" or dircur.include?("/file/system")

              file = File.open("#{dirpath}#{input_3}")
              $content = file.readlines
              file.close
              $content.each do |item|
                puts item
              end
              loop do
                print "#{input_3}> "
                edit = gets.chomp
                break if edit == "quit"
                break if edit == ""
                if edit.include? " "
                  edit_2 = afterspace(edit)
                  edit = beforespace(edit)
                  case edit
                  when "read"
                    if edit_2 == "all"
                      $content.each do |item|
                        puts item
                      end
                    else
                      if edit_2.to_i < 0 or edit_2.to_i > $content.size-1
                        puts "FileError: #{edit_2} is not a valid file line of #{input_3}"
                      else
                        puts $content[edit_2.to_i].gsub('\n','')
                      end
                    end
                  when "append"
                    $content.push("#{edit_2}\n")
                    updatefile("#{dirpath}#{input_3}")
                    file.close
                  when "delete"
                    if edit_2 == "all"
                      $content = []
                    else
                      if edit_2.to_i < 0 or edit_2.to_i > $content.size-1
                        puts "FileError: #{edit_2} is not a valid file line of #{input_3}"
                      else
                        puts $content.delete($content[edit_2.to_i])
                      end
                    end
                    updatefile("#{dirpath}#{input_3}")
                  end
                else
                  puts "CommandError: All commands for file::edit have at least one input."
                end
              end
              updatefile("#{dirpath}#{input_3}")
            else
              puts "FileError: Cannot create, delete, or edit files under `/file` or `/file/system`."
            end
          else
            puts "FileError: No file `#{input_3}` under `#{dircur}`."
          end
        when "read"
          if File.exist?("#{dirpath}#{input_3}")
            file = File.open("#{dirpath}#{input_3}")
            puts file.read
            file.close
          else
            puts "FileError: No file `#{input_3}` under `#{dircur}`."
          end
        when "execute"
          if File.exist?("#{dirpath}#{input_3}")
            load "./file/system/read_fxg.rb"
            execute "#{dirpath}#{input_3}"
          else
            puts "FileError: No file `#{input_3}` under `#{dircur}`."
          end
        else
          puts "CommandError: No command '#{input_2}' for file."
        end
      else
        puts "CommandError: All commands for file have at least one input."
      end
    end
  else
    puts "CommandError: Invalid command: '#{input}'"
  end
end
