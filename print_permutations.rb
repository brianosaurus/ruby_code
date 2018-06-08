#!/usr/bin/env ruby

def permute(str, l, r)
  if l == r
    puts  str
  else
    for i in l..r
      str[l], str[i] = str[i], str[l]
      permute(str, l+1, r)
      str[i], str[l] = str[l], str[i]
    end
  end
end

str = 'abc'
permute(str, 0, str.length - 1)

print "\n"

str = 'abcd'
permute(str, 0, str.length - 1)
