List = {"M": "I ", "Mam": "I Am ", "Jy": "Happy "}

class String
  def upper?
    self == self.upcase
  end

  def lower?
    self == self.downcase
  end
end

input = gets.chomp
words = []

input.each_char do |letter|
  if letter.upper?
    words[words.length] = letter
  else
    words[words.length-1] += letter
  end
end

