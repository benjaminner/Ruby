list = [1,1]
phi = [0,]
print 'length: '
for x in 0...gets.chomp.to_i-2
  list[x+2] = list[x]+list[x+1]
  phi[x+2] = list[x+1].fdiv(list[x])
end
puts list
puts '----'
puts phi[2...phi.length]
