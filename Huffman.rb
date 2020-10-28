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
