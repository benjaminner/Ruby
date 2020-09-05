$a = 0
$b = 0
$c = 0
$d = 0
$e = 0
$f = 0
$g = 0
$h = 0
$i = 0
$j = 0
$k = 0
$l = 0
$m = 0
$n = 0
$o = 0
$p = 0
$q = 0
$r = 0
$s = 0
$t = 0
$u = 0
$v = 0
$w = 0
$x = 0
$y = 0
$z = 0
$list_of_symbols = ["<", "=", "<=", ">=", "!="]

def round(thing, decis=0)
  thing.round(decis)
end
def int(thing)
  thing = thing.to_s
  if thing.include?(".")
    return thing[0...thing.index(".")].to_i
  end
end
def frac(thing)
  thing = thing.to_s
  if thing.include?(".")
    tof = "0.#{thing[thing.index(".")+1..thing.length]}".to_f
    toi = "0.#{thing[thing.index(".")+1..thing.length]}".to_i
    if tof == toi
      toi
    else
      tof
    end
  else
    0
  end
end

class String
  def lowercase
    array = []
    if /[^!><=]=[^=]/ =~ self
      self.replace(self.insert(self.index('='), '='))
    end
    self.gsub("^", "**").gsub('x', '*').gsub('i(', 'int(').gsub('f(', 'frac(').gsub('r(', 'round(').gsub('/', '.fdiv ').each_char do |char|
      if /[A-Z]/ =~ char
        array.push("$")
        array.push(char.downcase)
      else
        array.push(char)
      end
    end
    return array.join
  end
end