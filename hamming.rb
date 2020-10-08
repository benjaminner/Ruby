$number_of_bits = 16
####################
$bits = []
x = 0
while x < $number_of_bits
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
def calc_onebits
  onebits = []
  x = 0
  $bits.each do |bit|
    onebits.push(x) if bit
    x += 1
  end
  onebits
end
def checker
  onebits = calc_onebits
  xor = 0
  onebits.each do |onebit|
    xor^=onebit
  end
  xor
end
def setter
  bits_size = $number_of_bits/2
  while bits_size > 0
    if checker >= bits_size
      flipbit(bits_size)
    end
    bits_size /= 2
  end
  onebits = calc_onebits
  if onebits.size % 2 == 1
    flipbit(0)
  end
end
def hamming
  onebits = calc_onebits
  if checker != 0
    if onebits.size % 2 == 1
      flipbit(checker)
    else
      puts "Abort! Abort! Resend the data!"
    end
  else
    if onebits.size % 2 == 1
      flipbit(0)
    else
      puts "No errors!"
    end
  end
end
class Array
  def joingsub
    self.join(', ').gsub('true', '1').gsub('false', '0').gsub(', ', '')
  end
end
setter
puts $bits.joingsub
toflip = rand($number_of_bits)
puts("Hey, I'm flipping #{toflip}!")
flipbit(toflip)
puts $bits.joingsub
puts "Hey, I'm fixing #{checker}!"
hamming
puts $bits.joingsub