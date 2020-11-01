cron = File.open('/Users/ben/Desktop/Screentime.txt','a')
cron.puts('0')
cron.close

cron = File.open('/Users/ben/Desktop/ScreenTime/ScreenDates.txt','a')
cron.puts(`date`)
cron.close
