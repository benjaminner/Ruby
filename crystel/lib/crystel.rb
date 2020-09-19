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
    self.replace(@value[num1...num2])
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
  def adt
    self.additorial
  end
  def fct
    self.factorial
  end
  def radt
    x = 1
    while x.adt <= self
      x += 1
    end
    x -= 1
    return "#{x} additorial is #{x.adt}. You are #{self-x.adt} off!"
  end
  def rfct
    x = 1
    while x.fct <= self
      x += 1
    end
    x -= 1
    return "#{x} factorial is #{x.fct}. You are #{self-x.fct} off!"
  end
  def d(number)
    self.fdiv(number)
  end
  def xx
    puts self**self
  end
end

class Object
  def putsjson
    if self.case == Hash or self.case == Array
      JSON.generate(self)
    end
  end
  def from_prompt(user_input)
    puts user_input
    self.replace(gets.chomp)
  end
end

class String
  def getsjson
    JSON.parse(self)
  end
  def all_upper?
    self == self.upcase
  end
  def all_lower?
    self == self.downcase
  end
  def upper?(digit)
    self[digit] == self[digit].downcase
  end
  def lower?(digit)
    self[digit] == self[digit].upcase
  end
  def in(bigger_thing)
    bigger_thing.include? self
  end
  def beforespace
    self[0...self.index(" ")]
  end
  def afterspace
    self[self.index(" ")+1..self.length]
  end
  def allof(small, big)
    at = []
    
  end
  def del(*to_delete)
    alslf = self
    to_delete.each do |item|
      alslf.gsub!(item, '')
    end
    alslf
  end
end 

def expect(yesOrNo, test_name="Test")
  puts "#{test_name} Passed: #{yesOrNo}"
end

def raw_input(prompt)
  print prompt
  gets.chomp
end

def range(num1, num2=0)
  if num2 == 0
    0...num1
  else
    num1...num2
  end
end
class Deck
  attr_accessor :position
  attr_accessor :groups
  def swap(one=rand(@position.size), two=rand(@position.size))
    swap = @position[one]
    @position[one] = @position[two]
    @position[two] = swap
    self
  end
  def shuffle
    for x in 0..200
      swap
    end
    self
  end
  def initialize
    @position = []
    @groups = []
    ["c", "h", "s", "d"].each do |suit|
      for card in 2..10
        @position.push("#{card}#{suit}")
      end
      ["a", "j", "q", "k"].each do |card|
        @position.push("#{card}#{suit}")
      end
    end
    shuffle
  end
  def card_at(card)
    @position[card]
  end
  def index_of(card)
    @position.index(card)
  end
  def top(number)
    if number > @position.length + 1
      @position
    else
      @position[0...number]
    end
  end
  def deal(num_cards, num_hands)
    for i in 0...num_hands
      @groups.push(top(num_cards))
      for x in 0...num_cards
        @position.shift
      end
    end
    self
  end
  def combine
    @position.push(@groups.flatten).flatten!
    @groups = []
    self
  end
  def deal_in
    combine
  end
  def group_no(group, top_no, place, placein=1)
    if (1..@groups.length).include?(place)
      @groups[place-1].insert(placein-1, @groups[group-1][0...top_no]).flatten!
      @groups[group-1][0...top_no].each do |card|
        @groups[group-1].delete(card)
      end
    else
      @position.insert(placein-1, @groups[group-1][0...top_no]).flatten!
      @groups[group-1][0...top_no].each do |card|
        @groups[group-1].delete(card)
      end
    end
  end
end
class EukerDeck < Deck
  def initialize
    @position = []
    @groups = []
    ["c", "h", "s", "d"].each do |suit|
      [9, 10, "a", "j", "q", "k"].each do |card|
        @position.push("#{card}#{suit}")
      end
    end
    shuffle
  end
end