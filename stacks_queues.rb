#!/usr/bin/env ruby

# three in one
class MultiStack
  attr_accessor :values, :sizes, :capacity, :number_stacks

  class StackFullException < StandardError
  end

  class StackEmptyException < StandardError
  end

  def initialize(total_capacity, number_stacks)
    raise StandardError, 'bad stack args' if total_capacity <= 0 || number_stacks <= 0

    self.values = Array.new(total_capacity)
    self.sizes = Array.new(number_stacks, 0)
    self.number_stacks = number_stacks
  end

  def push(value, stack_number)
    raise StackFullException, 'The stack is full' unless stack_full(stack_number)

    self.values[stack_start(stack_number)] = value
    self.sizes[stack_number] += 1
  end

  def pop(stack_number)
    raise StackEmptyException, 'The stack is empty' if stack_empty(stack_number)
    tmp = self.values[stack_start(stack_number) - 1]
    self.sizes[stack_number] -= 1
    tmp
  end

  def peek(stack_number)
    raise StackEmptyException, 'The stack is empty' if stack_empty(stack_number)

    self.values[stack_start(stack_number) - 1]
  end

  private

  def allowed_stack_size
    self.values.length / self.number_stacks
  end

  def stack_start(stack_number)
    allowed_stack_size * stack_number + self.sizes[stack_number]
  end

  def stack_full(stack_number)
    allowed_stack_size = self.sizes[stack_number]
  end

  def stack_empty(stack_number)
    self.sizes[stack_number] == 0
  end

  def print_array
    puts self.values.join(' ')
  end

  def print_sizes
    puts self.sizes.join(' ')
  end
end

stack = MultiStack.new(100, 5)

stack.push('foo', 0)
stack.push('bar', 1)
# puts stack.peek(1)
# puts stack.peek(0)
# puts stack.pop(0)
# puts stack.pop(1)

puts 'Built a MultiStack'

stack.push('baz', 0)
stack.push('zab', 1)
puts stack.peek(1)
puts stack.peek(0)


