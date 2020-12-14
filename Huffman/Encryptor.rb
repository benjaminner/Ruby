aSCII = {
'0000000'=> 'µ',
'0000001'=> 'œ',
'0000010'=> '´',
'0000011'=> '®',
'0000100'=> '¡',
'0000101'=> '™',
'0000110'=> '£',
'0000111'=> '¢',
'0001000'=> '∞',
'0001001'=> '§',
'0001010'=> '¶',
'0001011'=> '•',
'0001100'=> '¯',
'0001101'=> 'ª',
'0001110'=> 'º',
'0001111'=> '⁄',
'0010000'=> '€',
'0010001'=> '‹',
'0010010'=> '›',
'0010011'=> 'ﬁ',
'0010100'=> 'ﬂ',
'0010101'=> '‡',
'0010110'=> '°',
'0010111'=> '·',
'0011000'=> '‚',
'0011001'=> '',
'0011010'=> 'Â',
'0011011'=> 'Ç',
'0011100'=> 'Ô',
'0011101'=> 'Ò',
'0011110'=> 'Á',
'0011111'=> 'Å',
'0100000'=> ' ',
'0100001'=>	'!',
'0100010'=>	'"',
'0100011'=>	'#',
'0100100'=>	'$',
'0100101'=>	'%',
'0100110'=>	'&',
'0100111'=>'\'',
'0101000'=>	'(',
'0101001'=>	')',
'0101010'=>	'*',
'0101011'=>	'+',
'0101100'=>	',',
'0101101'=>	'-',
'0101110'=>	'.',
'0101111'=>	'/',
'0110000'=>	'0',
'0110001'=>	'1',
'0110010'=>	'2',
'0110011'=>	'3',
'0110100'=>	'4',
'0110101'=>	'5',
'0110110'=>	'6',
'0110111'=>	'7',
'0111000'=>	'8',
'0111001'=>	'9',
'0111010'=>	':',
'0111011'=>	';',
'0111100'=>	'<',
'0111101'=>	'=',
'0111110'=>	'>',
'0111111'=>	'?',
'1000000'=>	'@',
'1000001'=>	'A',
'1000010'=>	'B',
'1000011'=>	'C',
'1000100'=>	'D',
'1000101'=>	'E',
'1000110'=>	'F',
'1000111'=>	'G',
'1001000'=>	'H',
'1001001'=>	'I',
'1001010'=>	'J',
'1001011'=>	'K',
'1001100'=>	'L',
'1001101'=>	'M',
'1001110'=>	'N',
'1001111'=>	'O',
'1010000'=>	'P',
'1010001'=>	'Q',
'1010010'=>	'R',
'1010011'=>	'S',
'1010100'=>	'T',
'1010101'=>	'U',
'1010110'=>	'V',
'1010111'=>	'W',
'1011000'=>	'X',
'1011001'=>	'Y',
'1011010'=>	'Z',
'1011011'=>	'[',
'1011100'=>'\\',
'1011101'=>	']',
'1011110'=>	'^',
'1011111'=>	'_',
'1100000'=>	'`',
'1100001'=>	'a',
'1100010'=>	'b',
'1100011'=>	'c',
'1100100'=>	'd',
'1100101'=>	'e',
'1100110'=>	'f',
'1100111'=>	'g',
'1101000'=>	'h',
'1101001'=>	'i',
'1101010'=>	'j',
'1101011'=>	'k',
'1101100'=>	'l',
'1101101'=>	'm',
'1101110'=>	'n',
'1101111'=>	'o',
'1110000'=>	'p',
'1110001'=>	'q',
'1110010'=>	'r',
'1110011'=>	's',
'1110100'=>	't',
'1110101'=>	'u',
'1110110'=>	'v',
'1110111'=>	'w',
'1111000'=>	'x',
'1111001'=>	'y',
'1111010'=>	'z',
'1111011'=>	'{',
'1111100'=>	'|',
'1111101'=>	'}',
'1111110'=> '~',
'1111111'=> 'å'
}
replacors = {
  '0000'=>'a',
  '0001'=>'b',
  '0010'=>'c',
  '0011'=>'d',
  '0100'=>'e',
  '0101'=>'f',
  '0110'=>'g',
  '0111'=>'h',
  '1000'=>'i',
  '1001'=>'j',
  '1010'=>'k',
  '1011'=>'l',
  '1100'=>'m',
  '1101'=>'n',
  '1110'=>'o',
  '1111'=>'p',
   '000'=>'q',
   '001'=>'r',
   '010'=>'s',
   '011'=>'t',
   '100'=>'w',
   '101'=>'x',
   '110'=>'y',
   '111'=>'z',
    '00'=>'A',
    '01'=>'B',
    '10'=>'C',
    '11'=>'D'
}

aSCII.each do |k,v|
  if not replacors.values.include?(v) and v != ',' and v != '0' and v != '1'
    replacors = {k=>v}.merge(replacors)
  end
end


def start()
  print 'Enter the text here: '
  text = gets.chomp.gsub('∏','π')
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
  return [lettersKys,text]
end

###PROGRAM 2###
def enc(text, ht)
  if ht.length != 1
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
    vals = vals.join
  else
    vals = "0"*text.length
  end
  return vals
end
class String
  def flatten
    return self
  end
end
ht = start()
text = ht[1]
ht = ht[0]

valuess = []
values2 = ht.flatten
ht.flatten.each do |letter|
  valuess.push(enc(letter, ht))
end
ht = {}
x = 0
values2.each do |item|
  ht[item] = valuess[x]
  x+=1
end


vals = ''
text.each_char do |char|
  vals+=ht[char]
end


leftovers = ''
x = 0
charbits = vals.scan(/.{1,7}/)
chars = charbits.pop if charbits.last.length != 7
vals = ''
charbits.each do |byte|
  vals+=(aSCII[byte])
end

x = 0
valuess.each do |value|
  replacors.keys.each do |valO|
    if value.include?(valO)
      valuess[x].gsub!(valO,replacors[valO])
    end
  end
  x+=1
end
puts "#{values2.join}∏#{valuess.join(',')}∏#{vals}∏#{chars}"
