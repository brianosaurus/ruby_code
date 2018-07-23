#!/usr/bin/env ruby

$max_width = 16
$words = ["This", "is", "an", "example", "of", "text", "justification."]

def words_for_line(words)
  count = 0
  lines = []
  index = 0
  line_index = 0
  while count <= $max_width && index <= words.size
    break if words[index].nil?
    if words[index].size + count > $max_width
      line_index += 1
      count = 0
    end

    count += words[index].size + 1

    lines[line_index] ||= []
    lines[line_index] << words[index]
    index += 1
  end

  lines
end

words_for_line($words).each do |line|
  if line.size == 1
    puts line[0]
    break
  end

  remaining_word_size = 0
  width_needed = $max_width - line.sum { |l| l.size }

  min_width_needed = width_needed / line[1..-1].size
  max_width_needed = width_needed % 2 == 0 ? min_width_needed : min_width_needed + 1

  out_str = line[0]

  line[1...-1].each do |word|
    out_str += " " * min_width_needed
    out_str += word
  end

  out_str += " " * max_width_needed
  out_str += line[line.size - 1]

  puts out_str
end
