long_file = "./all_words.txt"
numbers = {2 => [:a, :b, :c], 3 => [:d, :e, :f], 4 => [:g, :h, :i], 5 => [:j, :k, :l], 6 => [:m, :n, :o], 7 => [:p, :q, :r, :s], 8 => [:t, :u, :v], 9 => [:w, :x, :y, :z]}
#print "Hello! Please enter a phone number here: "
#input = gets.chomp
input = "7303814"
output = ""

input.each_char do |char|
  if numbers.has_key? char.to_i
    output += numbers[char.to_i][rand(3)].to_s
  else
    output += char
  end
end

puts output