require 'json'
require 'rubystats'
require 'crystel'
$text = "StockMarketSimulatorRuby.json"
def all_stocks_match?(stocks, cs)
  !stocks.map { |stock| cs.keys.include? stock }.include? false
end
def update
  file = open($text, 'r')
  file.rewind
  $current = JSON.parse(file.readline)
  file.close
  todelete = ""
  
  $current["Stocks"].each do |stock, stock_value|
    cs = $current["Stocks"]
    random_num = Rubystats::NormalDistribution.new(0, 0.05).rng.round(2)
    cs[stock] += random_num
    cs[stock] = cs[stock].round(2)
    if cs[stock] <= 0
      cs[stock] = 0
      todelete = stock
    end
    $current["Stocks"] = cs
  end
  ci = $current["Indexes"]
  cu = $current["User"]
  cs = $current["Stocks"]
  if all_stocks_match?(["LEMO", "HRCT", "RSRT"], cs)
    ci["$SEV"] = (cs["LEMO"] + cs["HRCT"] + cs["RSRT"]).round(2)
  end
  if all_stocks_match?(["NETW", "CPTR", "SOLR"], cs)
    ci["$TEK"] = (cs["NETW"] + cs["CPTR"] + cs["SOLR"]).round(2)
  end
  if all_stocks_match?(["CARS", "TRUK"], cs)
    ci["$TPT"] = (cs["CARS"] + cs["TRUK"]).round(2)
  end
  $current["Indexes"] = ci
  unless todelete == ""
    if $current["User"]["Stocks"].has_key?(todelete)
      $current["User"]["Stocks"].delete(todelete)
    end
    $current["Stocks"].delete(todelete)
    todelete = ""
  end
  file = open($text, 'w')
  file.write(JSON.generate($current))
  file.close
end
x = 0
while x < 5
  update
  x += 1
end
loop do
  print("+> ")
  request = gets.chomp
  break if request.include? "quit"
  break if request == ""
  x = 0
  while x < 5
    update
    x += 1
  end
  rf = request[0...request.index(" ")]
  re = request[request.index(" ")+1..request.length]
  cs = $current["Stocks"]
  cu = $current["User"]
  ci = $current["Indexes"]
  if rf == "info"
    if re == "account"
      puts cu
    elsif cs.include? re
      puts cs[re]
    elsif ci.include? re
      puts ci[re]
    else
      puts cs,ci
    end
  end
  if rf == "buy"
    rm = re[0...re.index(" ")]
    re = re[re.index(" ")+1..re.length].to_i
    if cs.include? rm
      if cs[rm] * re < cu["Cash"]
        cu["Cash"] -= cs[rm] * re
        if cu["Stocks"].include? rm
          cu["Stocks"][rm]["quantity"] += re
        else
          cu["Stocks"][rm] = {"quantity": re, "purchase": cs[rm], "current": cs[rm]}
        end
      end
    end
  end
  if rf == "sell"
    rm = re[0...re.index(" ")]
    re = re[re.index(" ")+1..re.length].to_i
    if cu.include? rm
      if re <= cu["Stocks"][rm]["quantity"]
        cu["Cash"] += cs[rm] * re
        if re == cu["Stocks"][rm]["quantity"]
          cu["Stocks"].delete(rm)
        else
          cu["Stocks"][rm]["quantity"] -= re
        end
      end
    end
  end
  if rf.include? "time" or rf.include? "warp"
    re = re.to_i
    x = 0
    while x < 5*re
      sleep(0.01)
      update
      x += 1
    end
  end
  accval = 0
  cu["Stocks"].each do |stock, stock_value|
    accval += cs[stock]*cu["Stocks"][stock]["quantity"]
    cu["Stocks"][stock]["current"] = cs[stock]
  end
  cu["Total"] = (accval + cu["Cash"]).round(2)
  cu["Cash"] = cu["Cash"].round(2)
  $current["User"] = cu
  file = open($text, 'w')
  file.write(JSON.generate($current))
  file.close
end