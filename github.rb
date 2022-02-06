puts `git diff`
puts `git add .`
print "Are you sure?(y/n) "
yn = gets.chomp
if yn == "y"
  print "Commit message: "
  message = gets.chomp
  puts `git commit -m "#{message}"`
  puts `git push`
end