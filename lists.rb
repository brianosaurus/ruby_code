#!/usr/bin/env ruby

class Node
  attr_accessor :data, :pointer

  def initialize(data, pointer = nil)
    self.data = data
    pointer = pointer
  end

   def next?
    !self.pointer.nil?
  end
end

class TestList
  attr_accessor :head
  attr_accessor :length

  def initialize
    self.length = 0
  end

  def insert_at_front(data)
    node = Node.new(data)

    if self.head
      node.pointer = self.head
      self.head = node
    else
      self.head = node
    end

    self.length += 1
  end

  def insert_at_end(data)
    node = self.head
    while node && node.next? do
      node = node.pointer
    end

    new_node = Node.new(data)

    unless self.head
      self.head = new_node
    else
      node.pointer = new_node
    end

    self.length += 1
  end

  def xxx
    node = self.head
    while node && node.next? do
      puts node.data
      node = node.pointer
    end

    puts node.data if node
  end
end

list = TestList.new
list.insert_at_end(1)
list.insert_at_end(1)
list.insert_at_end(2)
list.insert_at_end(2)
list.insert_at_end(3)
list.insert_at_end(1)

dups = {}

node = list.head
while node && node.next?
  dups[node.pointer.data] = true
  if dups[node.pointer.data]
    node.pointer = node.pointer.pointer
  end

  node = node.pointer
end

puts 'using a hash'
list.xxx

list = TestList.new
list.insert_at_end(1)
list.insert_at_end(1)
list.insert_at_end(2)
list.insert_at_end(2)
list.insert_at_end(3)
list.insert_at_end(1)

node = list.head
while node && node.next?
  runner = node
  while runner && runner.next?
    if node.data == runner.pointer.data
      runner.pointer = runner.pointer.pointer
    end

    runner = runner.pointer
  end

  node = node.pointer
end

puts 'using a runner'
list.xxx

list = TestList.new
list.insert_at_end(0)
list.insert_at_end(1)
list.insert_at_end(2)
list.insert_at_end(2)
list.insert_at_end(3)
list.insert_at_end(1)

def kthToLast(node, k)
  return 0 unless node

  index = kthToLast(node.pointer, k) + 1
  puts node.data if k == index

  return index
end

puts 'kthToLast'
kthToLast(list.head, 6)


list = TestList.new
list.insert_at_end(3)
list.insert_at_end(5)
list.insert_at_end(8)
list.insert_at_end(5)
list.insert_at_end(10)
list.insert_at_end(2)
list.insert_at_end(1)

def helper(node, pivot, high_list, low_list)
  if node
    if node.data < pivot
      low_list.insert_at_end(node.data)
    elsif node.data == pivot
      high_list.insert_at_front(node.data)
    else
      high_list.insert_at_end(node.data)
    end
  end
end

def partition(node, pivot)
  high_list = TestList.new
  low_list = TestList.new

  while node && node.next?
    helper(node, pivot, high_list, low_list)
    node = node.pointer
  end

  helper(node, pivot, high_list, low_list)

  result = TestList.new

  node = low_list.head
  while node
    result.insert_at_end(node.data)
    node = node.pointer
  end

  node = high_list.head
  while node
    result.insert_at_end(node.data)
    node = node.pointer
  end

  puts 'partition result'
  result.xxx
end

partition(list.head, 5)

list = TestList.new
list.insert_at_end('r')
list.insert_at_end('a')
list.insert_at_end('d')
list.insert_at_end('a')
list.insert_at_end('r')
list.insert_at_end('r')

class Result
  attr_accessor :node, :val

  def initialize(node, val)
    self.node = node
    self.val = val
  end
end

def recurse_palindrome(head, length)
  return Result.new(head, true) if head.nil? or length <= 0
  return Result.new(head.pointer, true) if length == 1

  res = recurse_palindrome(head.pointer, length - 2)

  return res if res.node.nil? || res.val == false

  res.val = (head.data == res.node.data)

  res.node = res.node.pointer
  res
end

res = recurse_palindrome(list.head, list.length)

puts 'palindrome test'
puts res.val
