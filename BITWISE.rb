def plus(x, y)
  ((((x&2)&(y&2))|(((x&2)^(y&2))&((x&1)&(y&1)))).to_s+(((x&2)^(y&2))^((x&1)&(y&1))).to_s+((x&1)^(y&1)).to_s).to_i(2)
end
def minus(x, y)
  
end