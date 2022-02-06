print 'decimal and repeating digits: '
drd = gets.chomp
decimal = drd.split(' ')
repd = decimal[1]
decimal = decimal[0]
numbered = decimal.split('.')
decimal = numbered[1]
numbered = numbered[0]
if repd == "" or repd == "0"
  puts "#{numbered} #{decimal}/#{'9'*decimal.length}"
end
