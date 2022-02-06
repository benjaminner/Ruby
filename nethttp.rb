require 'net/http'
print "site: "
typed = gets.chomp
uri = URI(typed)
res = Net::HTTP.get_response(uri)
def interp(res)
  rescode = res.code.to_i
  if rescode < 300 or rescode == 302 or rescode == 307 or rescode == 308
    puts "Success. Code #{rescode}"
  elsif 301
    puts res.body.downcase
    newsite = res.body[res.body.downcase.index("the document has moved <a href=\"")+35...res.body.downcase.index("\">here</a>.")]
    puts "Redirecting to #{newsite} (code 301)."
    uri = URI(newsite)
    res = Net::HTTP.get_response(uri)
    interp(res)
  else
    puts res.body
    raise "NetError: Failed request with code #{rescode}."
  end
end
interp(res)