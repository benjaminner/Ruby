inf = File.open("/Users/Ben/Downloads/usa.txt")
out = File.open('3-letter_words.txt','w')
inf.readlines.each do |word|
  if word.chomp.length == 3
    out.puts(word)
  end
end

inf.close
out.close
