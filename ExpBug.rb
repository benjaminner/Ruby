class String
  def upper?
    self == self.upcase
  end

  def lower?
    self == self.downcase
  end
end

input = gets.chomp

input.each do |letter|
  if letter.upper?
  end
end
