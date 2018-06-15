#!/usr/bin/env ruby

def move_to_bottom_right(maze, row, col)
  return true if row == (maze.length - 1) && col == (maze[0].length - 1)

  return false if row == maze.length || col == maze[0].length

  return false if maze[row][col] == :x

  # caching
  return false if maze[row][col] == 0
  maze[row][col] = 0

  return move_to_bottom_right(maze, row + 1, col) || move_to_bottom_right(maze, row, col + 1)
end

def magic_index(arr, offset)
  puts arr.join(' ')
  puts "offset #{offset}"

  if arr.length <= 2
    puts "Small array offset #{offset}"
    if arr[0] == 0 + offset || arr[1] == 1 + offset
      puts "Found it!"
      return true
    end

    return false
  end

  mid = arr.length / 2

  if arr[mid] == mid + offset
    puts "Mid #{mid} arr[mid] #{arr[mid]}"
    puts "Found it!"
    return true
  end

  puts "Mid #{mid} arr.length #{arr.length}"

  magic_index(arr[(mid+1)..-1], offset + arr[0..mid].length)
  magic_index(arr[0...mid], offset)
end

def calculate_subsets(set, index)
  allSubsets = Set.new

  if set.size == index
    allSubsets.add(Set.new)
  else
    allSubsets = calculate_subsets(set, index + 1)
    :q!
  end
end

maze = [
  [ 1,  1, :x, 1],
  [ :x, 1, 1, :x],
  [ 1, :x, :x, :x ],
  [ :x, 1, :x, 1 ]
]

magic = [-10, -5, 2, 2, 2, 3, 4, 7, 9, 12, 13]

puts "Robot Maze"
puts move_to_bottom_right(maze, 0, 0)

puts "\nMagic index"
puts magic_index(magic, 0)

puts "\nSubsets of a set"

calculate_subsets(set)

