require 'crystel'
load "~/Desktop/Coding/Ruby/super_computer/file/system/read_fxg.rb"
require 'open-uri'
sysfile = "/Users/ben/Desktop/Coding/Ruby/super_computer/file/system/sys-info.json"
file = File.open(sysfile)
sysinfo = file.read.getsjson
version = sysinfo["version"]
file.close
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
            `cd .#{dircur};mkdir #{input_3}`
            puts "Made directory `#{input_3}` under `#{dircur}`."
          else
            puts "DirectoryError: Cannot create or delete directories under `/file` or `/file/system`."
          end
        elsif beforespace(input_2) == "delete"
          unless dircur == "/file" or dircur.include?("/file/system")
            if File.exist?("#{dirpath}#{input_3}/")
              `cd .#{dircur};rmdir #{input_3}`
              puts "Deleted directory `#{input_3}`."
            else
              puts "DirectoryError: No directory `#{input_3}` under `#{dircur}`."
            end
          else
            puts "DirectoryError: Cannot create or delete directories under `/file` or `/file/system`."
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
      elsif File.exist?("#{dirpath}#{input_2}/")
        dircur += "/#{input_2}"
      else
        puts "DirectoryError: No directory `#{input_2}` under `#{dircur}`."
      end
    end
    if beforespace(input) == "file"
      if input_2.include? " "
        input_3 = afterspace(input_2)
        input_2 = beforespace(input_2)
        
        case input_2
        when "create"
          `cd #{dirpath};touch #{input_3}`
          puts "Made file `#{input_3}` under `#{dircur}`."
        when "delete"
          if File.exist?("#{dirpath}#{input_3}")
            `cd #{dirpath};rm #{input_3}`
            puts "Deleted file `#{input_3}`."
          else
            puts "FileError: No file `#{input_3}` under `#{dircur}`."
          end
        when "edit"
          if File.exist?("#{dirpath}#{input_3}")
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
                    if edit_2.to_i == 0 or edit_2.to_i > $content.size
                      puts "FileError: #{edit_2} is not a valid file line of #{input_3}"
                    else
                      puts $content[edit_2.to_i-1].gsub('\n','')
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
                    if edit_2.to_i == 0 or edit_2.to_i > $content.size
                      puts "FileError: #{edit_2} is not a valid file line of #{input_3}"
                    else
                      puts $content.delete($content.index(edit_2.to_i))
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
          if input_3.include?(" ")
            execute
          end
          execute
          
        else
          puts "CommandError: No command '#{input_2}' for file."
        end
      else
        puts "CommandError: All commands for file have at least one input."
      end
    end
  end 
end