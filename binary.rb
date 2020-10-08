def binary(string)
  string2 = ""
  string.each_byte do |byte|
    byte = byte.to_s(2)
    for x in 0..(8 - byte.length)
      byte.insert(0, '0')
    end
    string2 += byte.to_s(2)
  end
  string2
end