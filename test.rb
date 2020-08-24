class Human
  def initialize(name, hobby)
    @name = name
    @hobby = hobby
  end
  attr_accessor :name, :hobby

end
class Adult < Human
  def talk
    puts "You need to wash up for dinner!"
  end
  
  def work
     puts "I'm in a meeting!"
   end
 end
 class Kid < Human
   def be_annoying
     puts "Mommy? Mommy? Mommy?"
   end
   def throw_a_fit
     puts "AAAARRARRRGGGGHHHH"
   end
 end