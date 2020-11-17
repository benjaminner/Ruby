cron = File.open('/Users/ben/Desktop/Screentime.txt','r')
lines = cron.readlines
cron.close
cron = File.open('/Users/ben/Desktop/Screentime.txt','w')
value = lines[lines.length-1].to_i
cron.puts(value+1)
cron.close
