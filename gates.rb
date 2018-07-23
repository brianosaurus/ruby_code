#!/usr/bin/env ruby

american = ['11:30', '13:15']
united   = ['12:45', '14:00']
quantas  = ['13:20', '15:20']

def convert_to_minutes(time)
  hours, minutes = time.split(':')
  hours.to_i * 60 + minutes.to_i
end

united = united.map { |time| convert_to_minutes(time) }
american = american.map { |time| convert_to_minutes(time) }
quantas = quantas.map { |time| convert_to_minutes(time) }

airlines = [
  united,
  american,
  quantas
]

def overlap(airlines)
  num_gates_needed = 0

  airlines = airlines.sort { |a,b| a[0] <=> b[0] }

  airlines.each_with_index do |airline1, index|
    break if index + 1 == airlines.size

    airlines[(index+1)..-1].each do |airline2|
      puts "airline1: #{airline1.inspect}"
      puts "airline2: #{airline2.inspect}"
      num_gates_needed += 1 if airline2[0] <= airline1[1] && airline1[0] <= airline2[1]
    end
  end

  num_gates_needed
end

puts overlap(airlines)
