require 'json'
class Crystel
  def initialize(value="")
    @value = value
  end
  attr_accessor :value
  def print
    @value
  end
  def blank_input
    @value = gets.chomp
  end
  def from_prompt(user_input)
    puts user_input
    @value = gets.chomp
  end
  def isin?(bigger_thing)
    bigger_thing.value.include? @value
  end
  def in(bigger_thing)
    bigger_thing.include? @value
  end
  def contains?(smaller_thing)
    @value.include? smaller_thing
  end
  def s(num1, num2=" ")
    if num2 == " "
      num2 = @value.length
    end
    @value[num1...num2]
  end
  def s!(num1, num2=" ")
    if num2 == " "
      num2 = @value.length
    end
    @value = @value[num1...num2]
  end
  def all_upper?
    @value == @value.upcase
  end

  def all_lower?
    @value == @value.downcase
  end
  def upper?(digit)
    @value[digit] == @value[digit].downcase
  end
  def lower?(digit)
    @value[digit] == @value[digit].upcase
  end
end

class Integer
  def additorial
    x = 1
    to_return = 0
    while x <= self
      to_return += x
      x += 1
    end
    to_return
  end
  def factorial
    x = self
    to_return = 1
    while x > 1
      to_return *= x
      x -= 1
    end
    to_return
  end
  def d(number)
    self.fdiv(number)
  end
end

class Object
  def putsjson
    if self.case == Hash or self.case == Array
      JSON.generate(self)
    end
  end
end

class String
  def getsjson
    JSON.parse(self)
  end
end