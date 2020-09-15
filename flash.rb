filein = './unscrambler/all_words.txt'
fileout = File.open('./five_letter_words.txt', 'w')

def only_letters?(word)
  !(/[^a-zA-Z]/ =~ word)
end

counter = 0

File.open(filein,'r').each do |currentline|
  currentline.chomp!
  if currentline.length > 2 && currentline.length < 6 && only_letters?(currentline)
    fileout.puts currentline
    counter += 1
  end
end

fileout.close

puts "COMPLETE! Output #{counter} words"

