input = File.readlines('input').map &:strip

NOOP = 'noop'
ADDX = 'addx'

class CPU
  attr_accessor :cycle, :x, :signal_strength_sum, :buffer
  def initialize
    @cycle=0
    @x=1
    @signal_strength_sum=0
    @buffer=[]
  end

  def tick1
    self.cycle+=1
    if (cycle-20) % 40 == 0
      self.signal_strength_sum += signal_strength
    end
  end

  def tick2
    draw
    self.cycle+=1
  end

  def addx(n)
    tick2
    tick2
    self.x+=n
  end

  def noop
    tick2
  end

  def signal_strength
    self.cycle * self.x
  end

  def draw
    hz_pos=(cycle%40)
    char = sprite_range.include?(hz_pos) ? '#' : '.'
    buffer[hz_pos] = char
    flush if buffer.length == 40
  end

  def sprite_range
    (x-1..x+1).to_a
  end

  def flush
    puts buffer.join('')
    self.buffer=[]
  end
end


cpu = CPU.new
input.each do |line|
  cmd, value = line.split(' ')
  if cmd == NOOP
    cpu.noop
  elsif cmd == ADDX
    cpu.addx(value.to_i)
  end
end
# p1
# p cpu.signal_strength_sum

# p2 prints itself :)
