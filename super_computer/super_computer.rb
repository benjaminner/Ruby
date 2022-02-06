require 'json'
require 'open-uri'
require 'date'
version = '3.6.0'
technicalVersion = '1.3.6.0.0'
versionName = 'freedom'
is_online = `curl -s https://benstrens.com` != ""
doneupdate = false
if is_online
  webversion = /[0-9]\.[0-9]\.[0-9]/.match(`curl -s https://benstrens.com/super_computer/`)
  webversion = /[0-9]\.[0-9]/.match(`curl -s https://benstrens.com/super_computer/`) if webversion == nil
  webversion = webversion[0]
  if webversion != version
    `curl -s https://benstrens.com/super_computer/super_computer.rb > super_computer.rb`
    doneupdate = true
    if not File.exist?('file')
      doneupdate = false
      exec('ruby super_computer.rb')
    end
  end
end

if not File.exist?('file')
  puts 'You need to set up the super_computer environment.'
  print 'Would you like to set up the folders and files?(y/n) '
  if gets.chomp == 'y'
    `touch super_computer;echo "cd \`pwd\`; ruby super_computer.rb" > super_computer;chmod +x super_computer;mkdir file;cd file;mkdir user;mkdir system`
  else
    exec('echo Please allow super_computer to set up the files and folders to continue.')
  end
end
if not File.exist?('./file/system/prompt.txt')
  `cd file/system;touch prompt.txt;echo '*D>' > prompt.txt`
end
if not File.exist?('./file/system/dateformat.txt')
  `cd file/system;touch dateformat.txt;echo 'mdy' > dateformat.txt`
end
if not File.exist?('./file/system/alias.txt')
  `cd file/system;touch alias.txt;echo '{}' > alias.txt`
end
if not File.exist?('./file/system/documentation.txt')
  `cd file/system;touch documentation.txt;curl -s https://benstrens.com/super_computer/README.txt > documentation.txt`
end

if is_online
  webversion = /[0-9]\.[0-9]\.[0-9]/.match(`curl -s https://benstrens.com/super_computer/`)
  webversion = /[0-9]\.[0-9]/.match(`curl -s https://benstrens.com/super_computer/`) if webversion == nil
  webversion = webversion[0]
  if webversion != version
    `curl -s https://benstrens.com/super_computer/fxg_vars.rb > ./file/system/fxg/fxg_vars.rb`
    `curl -s https://benstrens.com/super_computer/read_fxg.rb > ./file/system/fxg/read_fxg.rb`
    `curl -s https://benstrens.com/super_computer/README.txt > ./file/system/documentation.txt`
  end
end

if doneupdate
  exec('ruby super_computer.rb')
end

dircur = "/file/user"
puts "super_computer.rb"
puts "scos #{versionName} (#{version})"
def beforespace(input)
  input[0...input.index(" ")]
end
def afterspace(input)
  input[input.index(" ")+1..input.length]
end
def updatefile(string)
  file = File.open(string, "w")
  $content.each do |line|
    file.write(line)
  end
  file.close
end
def dt
  DateTime.now
end
file = File.open('./file/system/dateformat.txt')
  dfmt = file.readline
file.close
badextentions = ['.','..','../','./']
counts = 1
toprintf = File.open('./file/system/prompt.txt')
toprint = toprintf.readline.gsub("\n",'')
toprintf.close
aliases = []
file = File.open('./file/system/alias.txt')
  freadedline = file.readline
  mtc = /".*"=>".*"/
  mtcr = mtc.match(freadedline)
  if mtcr
    freadedline.gsub!(mtcr[0],mtcr[0].gsub("=>",":"))
  end
  aliases = JSON.parse(freadedline)
file.close
loop do
  toprinted = dt.strftime(toprint).gsub('*D',dircur).gsub('*C',counts.to_s).gsub('*V',version)
  dirpath = ".#{dircur}/"
  print "#{toprinted} "
  input_4 = gets.chomp
  inputig = input_4.downcase

  break if inputig.include? "quit" or inputig == "" or inputig.include? "exit"
  input = inputig
  aliases.each do |aliass|
    #aliass = JSON.parse(aliass)
    matcher = /(\A#{aliass[0]} )|( #{aliass[0]} )|( #{aliass[0]}\z)|(\A#{aliass[0]}\z)/
    matched = matcher.match(inputig)
    if matched
      input = inputig.gsub(matched[0],matched[0].gsub(aliass[0],aliass[1]))
    end
  end


  if input.include? " "
    input_a = beforespace(input)
    input_2 = afterspace(input)
    if input_a == "dir"
      if input_2.include?(" ")
        input_3 = afterspace(input_2)
        if beforespace(input_2) == "create"
          unless dircur == "/file" or dircur.include?("/file/system")
            unless File.exist?("#{dirpath}#{input_3}/")
              Dir.mkdir("#{dirpath}#{input_3}")
              puts "Made directory `#{input_3}` under `#{dircur}`."
            else
              puts "DirectoryError: Cannot create directories that already exist."
            end
          else
            puts "DirectoryError: Cannot create or delete directories under `/file` or `/file/system`."
          end
        elsif beforespace(input_2) == "delete"
          unless dircur == "/file" or dircur.include?("/file/system")
            if File.exist?("#{dirpath}#{input_3}/")
              if Dir["#{dirpath}#{input_3}/*"] == []
                Dir.delete("#{dirpath}#{input_3}")
                puts "Deleted directory `#{input_3}`."
              else
                puts Dir["#{dirpath}#{input_3}/*"].join("\n").gsub("#{dirpath}#{input_3}/",'')
                print "The files above will be deleted. Are you sure?(y/n) "
                if gets.chomp == 'y'
                  puts 'deleting...'
                  Dir["#{dirpath}#{input_3}/*"].each do |file|
                    File.delete(file)
                  end
                  Dir.delete("#{dirpath}#{input_3}")
                end
              end
            else
              puts "DirectoryError: No directory `#{input_3}` under `#{dircur}`."
            end
          else
            puts "DirectoryError: Cannot create or delete directories under `/file` or `/file/system`."
          end
        elsif beforespace(input_2) == "sw"
          if File.exist?("#{dirpath}#{input_3}/") and not input_3.include?('.')
            dircur += "/#{input_3}"
          else
            puts "DirectoryError: No directory `#{afterspace(input_2)}` under `#{dircur}`."
          end
        elsif beforespace(input_2) == "split"
          unless dircur == "/file" or dircur.include?("/file/system")
            if File.exist?("#{dirpath}#{input_3}/")
              if Dir["#{dirpath}#{input_3}/*"] == []
                Dir.delete("#{dirpath}#{input_3}")
                puts "Deleted directory `#{input_3}`."
              else
                filesinside = Dir["#{dirpath}#{input_3}/*"].join("\n").gsub("#{dirpath}#{input_3}/",'').split("\n")
                filesinside.each do |filer|
                  `cd #{dirpath}#{input_3};mv #{filer} ../`
                end
                Dir.delete("#{dirpath}#{input_3}")
              end
            else
              puts "DirectoryError: No directory `#{input_3}` under `#{dircur}`."
            end
          else
            puts "DirectoryError: Cannot split directories under `/file` or `/file/system`."
          end
        elsif beforespace(input_2) == "move"
          unless dircur == "/file" or dircur.include?("/file/system")
            if input_3.include?(" ")
              if File.exist?("#{dirpath}#{beforespace(input_3)}")
                if File.exist?("#{dirpath}#{afterspace(input_3)}")
                  `cd #{dirpath}; mv #{beforespace(input_3)} #{afterspace(input_3)}`
                else
                  puts "DirectoryError: No directory `#{afterspace(input_3)}` under `#{dircur}`."
                end
              else
                puts "DirectoryError: No file or directory `#{beforespace(input_3)}` under `#{dircur}`."
              end
            else
              puts "DirectoryError: Please specify both the file or directory you want to move and the directory you want to move it to."
            end
          else
            puts "DirectoryError: Cannot move files or directories under `/file` or `/file/system`."
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
        puts Dir["#{dirpath}#{input_3}/*"].join("\n").gsub("#{dirpath}#{input_3}/",'')
      elsif input_2 == "cur"
        puts dircur
      else
        puts "CommandError: No command '#{input_2}' for dir."
      end
    elsif input_a == "file"
      if input_2.include? " "
        input_3 = afterspace(input_2)
        input_2 = beforespace(input_2)

        case input_2
        when "create"
          unless dircur == "/file" or dircur.include?("/file/system")
            unless File.exist?("#{dirpath}#{input_3}")
              File.new("#{dirpath}/#{input_3}",'w')
              puts "Made file `#{input_3}` under `#{dircur}`."
            else
              puts "FileError: Cannot create files that already exist."
            end
          else
            puts "FileError: Cannot create, delete, or edit files under `/file` or `/file/system`."
          end
        when "delete"
          if File.exist?("#{dirpath}#{input_3}")
            unless dircur == "/file" or dircur.include?("/file/system")
              File.delete("#{dirpath}#{input_3}")
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
                break if edit.include? "quit" or edit == "" or edit.include? "exit"
                if edit.include? " "
                  edit_2 = afterspace(edit)
                  edit = beforespace(edit)
                  isnspace = false
                  if edit_2.include? " "
                    isnspace = true
                    edit_3 = afterspace(edit_2)
                    edit_4 = beforespace(edit_2)
                  end
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
                  when "replace"
                    if isnspace
                      if edit_4.to_i < 0 or edit_4.to_i > $content.size-1
                        puts "FileError: #{edit_4} is not a valid file line of #{input_3}"
                      else
                        $content[edit_2.to_i] = edit_3
                        updatefile("#{dirpath}#{input_3}")
                      end
                    else
                      puts "FileError: Please give both a line number and what you want to replace it with."
                    end
                  when "insert"
                    if isnspace
                      if edit_4.to_i < 0 or edit_4.to_i > $content.size-1
                        puts "FileError: #{edit_4} is not a valid file line of #{input_3}"
                      else
                        $content.insert(edit_2.to_i+1,edit_3)
                        updatefile("#{dirpath}#{input_3}")
                      end
                    else
                      puts "FileError: Please give both a line number and what you want to replace it with."
                    end
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
                  when "length"
                    if edit_2 == "all" or edit_2 == "file" or edit_2 == "lines"
                      puts $content.length
                    elsif edit_2 == "words"
                      wordcount = 0
                      $content.each do |line|
                        wordcount+=(line.gsub("\n","").count(' ')+1)
                      end
                      puts wordcount
                    elsif edit_2 == "characters" or edit_2 == "chars"
                      charcount = 0
                      $content.each do |line|
                        charcount+=line.gsub("\n","").length
                      end
                      puts charcount
                    else
                      if edit_2.to_i < 0 or edit_2.to_i > $content.size-1 or (edit_2.to_i == 0 && edit_2 != '0')
                        puts "FileError: #{edit_2} is not a valid file line of #{input_3}"
                      else
                        puts $content[edit_2.to_i].gsub("\n","").length
                      end
                    end
                  else
                    puts "CommandError: No command '#{input_2}' for file:edit."
                  end
                else
                  puts "CommandError: All commands for file:edit have at least one input."
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
            if File.exist?("./file/system/fxg/")
              load "./file/system/fxg/read_fxg.rb"
              execute "#{dirpath}#{input_3}"
            else
              is_online = `curl -s https://benstrens.com` != ""
              if not is_online
                puts "You need to install the FXG handler and you are currently offline. If you want to use file:execute please connect to the internet."
              else
                print "You need to install the FXG handler before using file:execute. Would you like to install?(y/n) "
                if gets.chomp == 'y'
                  `cd file/system;mkdir fxg;cd fxg;curl -s https://benstrens.com/super_computer/read_fxg.rb > read_fxg.rb;curl -s https://benstrens.com/super_computer/fxg_vars.rb > fxg_vars.rb`
                  load "./file/system/fxg/read_fxg.rb"
                  execute "#{dirpath}#{input_3}"
                end
              end
            end
          else
            puts "FileError: No file `#{input_3}` under `#{dircur}`."
          end
        else
          puts "CommandError: No command '#{input_2}' for file."
        end
      else
        puts "CommandError: All commands for file have at least one input."
      end
    elsif input_a == "system"
      if input_2 == "time"
        puts dt.strftime('%I:%M:%S %p')
      elsif input_2 == "time 24h"
        puts dt.strftime('%H:%M:%S')
      elsif input_2 == "time zone"
        puts "#{dt.strftime('%Z')} #{Time.now.getlocal.zone}"
      elsif input_2 == "date"
        puts dt.strftime('%A, %B %d, %Y')
      elsif input_2 == "date short"
        dd = dfmt.gsub('y','Y').split('')
        puts dt.strftime("%#{dd[0]}/%#{dd[1]}/%#{dd[2]}")
      elsif input_2 == "current prompt"
        puts toprint
      elsif input_2 == "date format"
        file = File.open('./file/system/dateformat.txt')
           dfmt = file.readline
        file.close
        puts dfmt
      elsif input_2.include?("date format ") and input_2 != "date format "
        idc = input_2.split("date format ")[1]
        if (idc.count("m") == idc.count("d") and idc.count("d") == idc.count("y") and idc.count("y") == 1) and idc.length == 3
          dfmt = idc
          file = File.open('./file/system/dateformat.txt','w')
            file.write(dfmt)
          file.close
        else
          puts "SystemError: '#{idc}' is not a valid date format."
        end
      elsif beforespace(input_2) == "prompt" && input_2.include?(' ')
        file = File.open("./file/system/prompt.txt",'w')
        file.write(afterspace(afterspace(input_4)))
        file.close
        toprint = afterspace(afterspace(input_4))
      elsif beforespace(input_2) == "alias"
        array = afterspace(input_2).split('=')
        file = File.open('./file/system/alias.txt')
        freadedline = file.readline
        mtc = /".*"=>".*"/
        mtcr = mtc.match(freadedline)
        if mtcr
          freadedline.gsub!(mtcr[0],mtcr[0].gsub("=>",":"))
        end
        fileline = JSON.parse(freadedline)
        file.close
        file = File.open('./file/system/alias.txt','w')
        fileline[array[0]]=array[1]
        file.write(fileline)
        file.close
        aliases[array[0]]=array[1]
      elsif input_2 == "list aliases"
        aliases.each do |aliaso|
          puts aliaso.join('=>')
        end
      elsif input_2 != "delete alias " and input_2.include?("delete alias ")
        dreq = afterspace(inputig).split("delete alias ")[1]
        if aliases.keys.include?(dreq)
          print 'Are you sure? This action cannot be undone! (y/n) '
          if gets.chomp == 'y'
            file = File.open('./file/system/alias.txt')
            freadedline = file.readline
            mtc = /".*"=>".*"/
            mtcr = mtc.match(freadedline)
            if mtcr
              freadedline.gsub!(mtcr[0],mtcr[0].gsub("=>",":"))
            end
            fileline = JSON.parse(freadedline)
            file.close
            file = File.open('./file/system/alias.txt','w')
            fileline.delete(dreq)
            file.write(fileline)
            file.close
            aliases.delete(dreq)
          end
        else
          puts "SystemError: No alias '#{dreq}' exists."
        end
      elsif input_2 == "delete aliases"
        print 'Are you sure? This action cannot be undone! (y/n) '
        if gets.chomp == 'y'
          aliases = {}
          file = File.open('./file/system/alias.txt','w')
          file.write("{}")
          file.close
        end
      else
        puts "CommandError: No command '#{input_2}' for system."
      end
    else
      puts "CommandError: Invalid command: '#{input_a}'"
    end
  elsif input == "help" or input == "documentation"
    print "You can visit https://benstrens.com/super_computer/README.txt for the documentation. Would you like to print it to screen (it is VERY long)? (y/n) "
    if gets.chomp == "y"
      file = File.open('./file/system/documentation.txt')
        puts file.readlines
      file.close
    end
  elsif input == "dir" or input == "file" or input == "system"
    puts "CommandError: No command for #{input} given."
  else
    puts "CommandError: Invalid command: '#{input_4}'"
  end
  counts+=1
end
