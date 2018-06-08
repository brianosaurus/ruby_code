#!/usr/bin/env ruby

# unique with bit vector
arr1 = ['a','b','c','d','e']
arr2 = ['a','b','c','d','e','e']
arr3 = ['a', 'a']

def unique(arr)
  vector = nil
  arr.each do |item|
    val = item.ord - ?a.ord
    if vector.nil?
      vector = (1 << val)
    elsif (vector & (1 << val)) != 0
      puts 'false'
      return
    else
      vector |= (1 << val)
    end
  end

  puts 'true'
end

puts 'testbing bit vector unique'
unique(arr1)
unique(arr2)
unique(arr3)

# check permutations
def check_permutations(str1, str2)
  str1.chars.sort(&:casecmp).join == str2.chars.sort(&:casecmp).join
end

puts 'check permutations'

str1 = 'abcd'
str2 = 'dcba'
puts check_permutations(str1, str2)
str2 = 'qwerty'
puts check_permutations(str1, str2)

# permutation of a palendrome
def perm_pal(str)
  vector = nil
  str.chars.each do |chr|
    val = chr.ord - ?a.ord

    if vector.nil?
      vector = (1 << val)
    else
      vector ^= (1 << val)
    end
  end

  return false if vector == 0
  return false if vector & (vector - 1) != 0

  true
end

puts 'Perm Pal'

str = 'tactcoapapa'
puts perm_pal(str)

str = 'tactcoapapaa'
puts perm_pal(str)

# one away
def lengths_off_by_1(longer, shorter)
  index2 = 0
  for i in 0..(shorter.length)
    if shorter[i] != longer[i]
      return false if index2 != i
      index2 += 1
    end

    index2 += 1
  end

  true
end

def equal_lengths(str1, str2)
  found_dif = false
  for i in 0..(str1.length-1)
    if str1[i] != str2[i]
      return false if found_dif
      found_dif = true
    end
  end

  true
end


def one_away(str1, str2)
  if str1.length == str2.length
    equal_lengths(str1, str2)
  elsif str1.length == (str2.length - 1)
    lengths_off_by_1(str1, str2)
  elsif str2.length == (str1.length - 1)
    lengths_off_by_1(str2, str1)
  else
    false
  end
end

puts 'One away'

str1 = 'pales'
str2 = 'paless'
puts one_away(str1, str2)

str1 = 'pales'
str2 = 'paxes'
puts one_away(str1, str2)

str1 = 'pales'
str2 = 'boats'
puts one_away(str1, str2)

# Rotate matrix
matrix = [
  [1, 1, 1, 1],
  [2, 2, 2, 2],
  [3, 3, 3, 3],
  [4, 4, 4, 4]
]

def rotate_matrix(matrix)
  n = matrix.size
  for layer in 0...(n / 2)
    first = layer
    last = n - layer - 1

    for i in first...last
      offset = i - first

      tmp = matrix[first][i] # top
      matrix[first][i] = matrix[last - offset][first] # left -> top

      matrix[last - offset][first] = matrix[last][last - offset] # bottom -> left

      matrix[last][last - offset] = matrix[i][last] # right -> bottom

      matrix[i][last] = tmp # move old top to top right
    end
  end
  print_matrix(matrix)
end

def print_matrix(matrix)
  matrix.each do |arr|
    puts arr.join(' ')
  end
end


puts 'Rotate Matrix'
rotate_matrix(matrix)
