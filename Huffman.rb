def start
  print 'Enter the text here: '
  text = gets.chomp
  letters = {}
  for x in 0...text.length
    letters[text[x]] = 1 if not letters.include?(text[x])
    letters[text[x]] += 1 if letters.include?(text[x])
  end
  lettersVls = letters.values.sort
  lettersK = letters.sort_by {|k, v| v}
  lettersKys = []
  for pair in lettersK
    lettersKys.push(pair[0])
  end
  while lettersKys.length > 2
    zero = lettersKys[0]
    one = lettersKys[1]
    sum = lettersVls[0] + lettersVls[1]
    letters.delete(zero)
    letters.delete(one)
    letters[[zero, one]] = sum

    lettersVls = letters.values.sort
    lettersK = letters.sort_by {|k, v| v}
    lettersKys = []
    for pair in lettersK
      lettersKys.push(pair[0])
    end
  end
  return lettersKys
end

###PROGRAM 2###
class String
  def flatten
    return self
  end
end
ht = start

print 'What would you like to do? '
todo = gets.chomp.downcase
loop do
  case todo
  when 'r'
    ht = start
  when 'p'
    puts ht.to_s
  when 'e'
    puts "Enter the text to be encoded here: "
    text = gets.chomp
    vals = Array.new(text.length,'')
    letternumber = 0
    text.each_char do |letter|
      htree = ht
      while htree.class == Array
        zero = htree[0]
        one = htree[1]
        if zero.flatten.include?(letter)
          htree = zero
          vals[letternumber] += '0'
        end
        if one.flatten.include?(letter)
          htree = one
          vals[letternumber] += '1'
        end
      end
      letternumber += 1
    end
    puts vals.join
  when 'd'
    puts 'Enter the binary to be decoded here: '
    numbers = gets.chomp
    read = 0
    length = 0
    decoded = ""
    numbers.each_char do |number|
      length += 1
      number = number.to_i
      currentSel = ht
      for x in 0...length
        currentSel = currentSel[numbers[x+read].to_i]
      end
      if currentSel.class == String
        decoded += currentSel
        read = length+read
        length = 0
      end
    end
    puts decoded
  else
    break
  end
  print 'What would you like to do? '
  todo = gets.chomp.downcase
end


##HuffmanENC.rb is for encoding and HuffmanDEC.rb is decoding.##
