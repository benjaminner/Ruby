$bits = []
x = 0
while x < 16
  $bits.push(rand(2))
  x += 1
end
x = 0
$bits.each do |bit|
  $bits[x] = false if bit == 0
  $bits[x] = true if bit == 1
  x += 1
end
def flipbit(bit)
  $bits[bit] = !$bits[bit]
end
def checker
  onebits = []
  x = 0
  $bits.each do |bit|
    onebits.push(x) if bit
    x += 1
  end
  xor = 0
  onebits.each do |onebit|
    xor^=onebit
  end
  xor
end
def setter
  if checker >= 8
    flipbit(8)
  end
  if checker >= 4
    flipbit(4)
  end
  if checker >= 2
    flipbit(2)
  end
  if checker >= 1
    flipbit(1)
  end
end
def hamming
  onebits = []
  x = 0
  $bits.each do |bit|
    onebits.push(x) if bit
    x += 1
  end
  if onebits.size % 2 == 1
    flipbit(checker) if checker != 0
  end
end
setter
puts $bits.join(', ')
toflip = rand(16)
puts("Hey, I'm flipping #{toflip}!")
flipbit(toflip)
puts $bits.join(', ')
puts "Hey, I'm fixing #{checker}!"
hamming
puts $bits.join(', ')