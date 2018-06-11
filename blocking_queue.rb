#!/usr/bin/env ruby

class BlockingQueue
  MAX_SIZE = 20
  attr_accessor :read_waiters, :write_waiters, :queue

  def initialize
    self.write_waiters = []
    self.read_waiters = []

    self.queue = []
  end

  def push(data)
    if self.queue.length >= MAX_SIZE
      self.write_waiters << Thread.current

      begin
        Thread.stop
      ensure
        self.write_waiters.delete(Thread.current)
      end
    end

    self.queue << data

    while t = self.read_waiters.shift
      break if t.wakeup
    end

    self
  end

  def pop
    while self.queue.empty?
      self.read_waiters << Thread.current
      begin
        Thread.stop
      ensure
        self.read_waiters.delete(Thread.current)
      end
    end

    ret = self.queue.shift

    while self.queue.length < MAX_SIZE
      while t = self.write_waiters.shift
        break if t.wakeup
      end
    end

    ret
  end
end


q = BlockingQueue.new

write_threads  = []
3.times do
  write_threads << Thread.new {
    10.times do
      q.push((rand * 100) % 55)
      puts "write #{q.queue.join(' ')}"
      sleep 0.1
    end
  }
end

puts "Done with write threads"

read_threads = []
3.times do
  read_threads << Thread.new {
    puts "Read thread running"
    begin
      while val = q.pop
        p "Read #{val}"
        sleep 0.1
      end
    rescue ThreadError
      puts "thread finish!"
    end
  }
end

write_threads.each do |t|
  puts "joining write thread #{t}"
  t.join
end

read_threads.each do |t|
  puts "joining read_thread #{t}:"
  t.join
end

puts "thread all joined"
