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