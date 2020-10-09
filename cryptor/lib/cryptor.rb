version = `curl -s https://benstrens.com/cryptor/ | grep -C 1 Version`[116..118]
if `gem list | grep cryptor | grep #{version}` == ""
    print "Hey! It looks like you are not running the latest version of cryptor. Would you like to update? [y/n]: "
  if gets.chomp == 'y'
    puts "Administrator's password may be required to install cryptor."
    puts `curl -s https://benstrens.com/cryptor/cryptor.gem > ~/Downloads/cryptor.gem;sudo gem install ~/Downloads/cryptor.gem;rm ~/Downloads/cryptor.gem`
  end
end

require 'io/console'
$symbols = {
'!' =>0,
'"' =>1,
'#' =>2,
'$' =>3,
'%' =>4,
'&' =>5,
'\''=>6,
'(' =>7,
')' =>8,
'*' =>9,
'+' =>10,
',' =>11,
'-' =>12,
'.' =>13,
'/' =>14,
'0' =>15,
'1' =>16,
'2' =>17,
'3' =>18,
'4' =>19,
'5' =>20,
'6' =>21,
'7' =>22,
'8' =>23,
'9' =>24,
':' =>25,
';' =>26,
'<' =>27,
'=' =>28,
'>' =>29,
'?' =>30,
'@' =>31,
'A' =>32,
'B' =>33,
'C' =>34,
'D' =>35,
'E' =>36,
'F' =>37,
'G' =>38,
'H' =>39,
'I' =>40,
'J' =>41,
'K' =>42,
'L' =>43,
'M' =>44,
'N' =>45,
'O' =>46,
'P' =>47,
'Q' =>48,
'R' =>49,
'S' =>50,
'T' =>51,
'U' =>52,
'V' =>53,
'W' =>54,
'X' =>55,
'Y' =>56,
'Z' =>57,
'[' =>58,
'\\'=>59,
']' =>60,
'^' =>61,
'_' =>62,
'`' =>63,
'a' =>64,
'b' =>65,
'c' =>66,
'd' =>67,
'e' =>68,
'f' =>69,
'g' =>70,
'h' =>71,
'i' =>72,
'j' =>73,
'k' =>74,
'l' =>75,
'm' =>76,
'n' =>77,
'o' =>78,
'p' =>79,
'q' =>80,
'r' =>81,
's' =>82,
't' =>83,
'u' =>84,
'v' =>85,
'w' =>86,
'x' =>87,
'y' =>88,
'z' =>89,
'{' =>90,
'|' =>91,
'}' =>92,
'~' =>93,
' ' =>94
}
def findchar(number)
  $symbols.each do |k, v|
    if v == number
      return k
    end
  end
end
def encrypt(message=nil,password=nil)
  if not message
    print "Message: "
    message = gets.chomp
  end
  if not password
    password = IO::console.getpass "Password: "
  end
  out = ""
  for x in 0...(message.size)
    out += findchar(($symbols[message[x]]+$symbols[password[x%password.size]]+x)%95)
  end
  out
end
def decrypt(message=nil,password=nil)
  if not message
    print "Message: "
    message = gets.chomp
  end
  if not password
    password = IO::console.getpass "Password: "
  end
  out = ""
  for x in 0...(message.size)
    out += findchar(($symbols[message[x]]-$symbols[password[x%password.size]]-x)%95)
  end
  out
end