require 'json'
gs = [1,1,1,0,0,0,2,2,2]
used = []
mt = JSON.parse((File.open "/Users/ben/Desktop/Coding/Ruby/Machine Learning/mt.json").readline)

print 'gs: '
gs = JSON.parse(gets.chomp)
#2
if gs == [1,1,1,2,0,0,0,2,2] or gs == [1,1,1,0,0,2,2,2,0]
case mt[0][rand(mt[0].size)]
when 0
  gs[1] = 0
  gs[5] = 1 if gs.last == 0
  gs[3] = 1 if gs.last == 2
  used.push("0,0")
when 1
  gs[4] = 1
  gs[1] = 0
  used.push("0,1")
when 2
  if gs.last == 0
    gs = [0,1,1,1,0,2,2,2,0]
  elsif gs.last == 2
    gs = [1,1,0,2,0,1,0,2,2]
  end
  used.push("0,2")
end

elsif gs == [1,1,1,0,2,0,2,0,2]

elsif gs == ["something"]
#4
end

puts gs.to_s,used
