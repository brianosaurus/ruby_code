#!/usr/bin/env ruby

class TreePrinter
  attr_accessor :is_branch
  attr_accessor :get_children
  attr_accessor :format_node
  attr_accessor :skip_root_node

  def initialize
    @arms = Hash.new("|   ")
    @arms[""]  = ""
    @arms["`"] = "    "
    @out = ""
    @format_node  = proc{|node| node.data.to_s}
  end

  def visit(root, leader, tie, arm, node)
    return if node.empty?

    node_str = @format_node.call(node)
    @out << "#{leader}#{arm}#{tie}#{node_str}\n"
    visitChildren(node, leader + @arms[arm])
    @out
  end

  def visitChildren(node, leader)
    kids = []

    return if node.empty?
    kids = node.get_adjacents

    arms = Array.new(kids.length - 1, "|") << "`"
    pairs = kids.zip(arms)
    pairs.each { |e|  visit(node, leader, "-- ", e[1], e[0]) }
  end

  def format(root)
    @root = root
    visit(root, "", "", "", root)
  end
end

class TestTree
  attr_accessor :head

  def push(data)
    if self.head.nil?
      self.head = Node.new(data)
    else
      self.head.push(data)
    end
  end

  def include?(data)
    if self.head.nil?
      false
    else
      self.head.include?(data)
    end
  end

  def to_a
    self.head&.to_a
  end

  class EmptyNode
    def get_nodes
      []
    end

    def get_adjacents
      []
    end

    def to_s
      ''
    end

    def to_a
      []
    end

    def include?(*)
      false
    end

    def push(*)
      false
    end

    def empty?
      true
    end

    alias_method :<<, :push

    def inspect
      "{}"
    end
  end

  class Node
    attr_accessor :left, :right, :data, :state

    def initialize(data)
      self.data = data
      self.left = EmptyNode.new
      self.right = EmptyNode.new
    end

    def get_adjacents
      [left, right]
    end

    def include?(data)
      case self.data <=> data
      when 1 then left.include?(data)
      when -1 then right.include?(data)
      when 0 then true
      end
    end

    def push(data)
      case self.data <=> data
      when 1 then push_left(data)
      when -1 then push_right(data)
      when 0 then push_left(data)
      end
    end
    alias_method :<<, :push

    def inspect
      "{#{data}:#{left.inspect}|#{right.inspect}}"
    end

    def to_a
      left.to_a + [data] + right.to_a
    end

    def to_s
      data.to_s
    end

    def get_nodes
      nodes = []
      nodes << self
      nodes << left.get_nodes
      nodes << right.get_nodes
      nodes.flatten
    end

    def adjacents
      [left, right]
    end

    def empty?
      false
    end

    private

    def push_left(data)
      left.push(data) || self.left = Node.new(data)
    end

    def push_right(data)
      right.push(data) || self.right = Node.new(data)
    end
  end
end


def get_deepest_level(node, level)
  return level if node.empty?

  left_level = get_deepest_level(node.left, level + 1)
  right_level = get_deepest_level(node.right, level + 1)

  return left_level < right_level ? right_level : left_level
end

def get_nodes_levels(node, level, nodes)
  return if node.empty?

  nodes << [level, node.data]

  get_nodes_levels(node.left, level + 1, nodes)
  get_nodes_levels(node.right, level + 1, nodes)
end

def breadth_first_search(tree, value)
  queue = Queue.new

  tree.head.get_nodes.each do |t|
    t.state = :unvisited unless t.empty?
  end

  tree.head.state = :visited

  queue << tree.head

  puts tree.head.data

  while !queue.empty? do
    t = queue.deq

    unless t.empty?
      t.get_adjacents.each do |a|
        next if a.empty?

        if a.state == :unvisited
          puts a.data

          a.state = :visited
          queue << a
        end
      end
    end
  end
end

def depth_first_search(node, value)
  return if node.empty?

  puts node.data
  depth_first_search(node.right, value)
  depth_first_search(node.left, value)
end

def min_bst(arr, tree)
  if arr.length <= 2
    arr.each { |n| tree.push(n) }
    return
  end

  val = arr[arr.length / 2]

  return unless val
  tree.push(val)

  min_bst(arr[0...(arr.length / 2)], tree)
  min_bst(arr[(arr.length / 2 + 1)..-1], tree)
end

def check_balanced(node, level)
  return level if node.empty?

  left_height = check_balanced(node.left, level + 1)
  right_height = check_balanced(node.right, level + 1)

  diff = (left_height - right_height).abs

  raise StandardError, 'imbalanced' if diff > 1

  return [left_height, right_height].max
end

def is_bst(node, min, max)
  return if node.empty?

  if min != nil && node.data <= min
    return false
  end

  if max != nil && node.data > max
    return false
  end

  if !is_bst(node.right, n.data, max) || is_bst(node.left, min, n.data)
    return false
  end

  true
end


tree = TestTree.new
arr = ['m', 'h', 'g', 'i', 'n', 's', 'o', 't', 'e', 'f', 'p', 'q', 'r']
arr.each { |x| tree.push(x) }

# puts 'breadth first search'
# breadth_first_search(tree, 'x')
# puts "\ndepth first search"
# depth_first_search(tree.head, 'x')
# puts "\n"

# puts TreePrinter.new.format(tree.head)


puts "\nMin BST"

arr = [1,2,3,4,5,6,7,8,9]
tree = TestTree.new

min_bst(arr, tree)

puts TreePrinter.new.format(tree.head)

# arr = ['m', 'h', 'g', 'i', 'n', 's', 'o', 't', 'e', 'f', 'p', 'q', 'r']
# tree = TestTree.new
# arr.each { |val| tree.push(val) }

# check_balanced(tree.head, 1)

arr = [1,2,3,4,5,6,7,8,9]
tree = TestTree.new

min_bst(arr, tree)
puts 'checking balanced'
check_balanced(tree.head, 1)

puts 'checking is a bst'
is_bst(tree.head)

tree = TestTree.new
tree.push(5)
tree.push(5)
puts TreePrinter.new.format(tree.head)
