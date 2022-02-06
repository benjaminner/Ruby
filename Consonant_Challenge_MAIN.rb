alphabet = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']

inf = File.open('3-letter_words.txt')
words=inf.readlines.map {|word| word.chomp}
inf.close


for x in alphabet
  for y in alphabet
    good = true
    for z in ['a','e','i','o','u']
      unless words.include?(x+z+y)
        good = false
      end
    end
    puts "#{x} #{y}" if good
  end
end
