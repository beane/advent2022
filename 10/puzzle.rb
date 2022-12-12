input = File.readlines('input').map &:strip

NOOP = 'noop'
ADDX = 'addx'

class CPU
  attr_accessor :cycle, :x, :signal_strength_sum
  def initialize
    @cycle=0
    @x=1
    @signal_strength_sum=0
  end

  def tick(&block)
    self.cycle+=1
    if (cycle-20) % 40 == 0
      self.signal_strength_sum += signal_strength
    end
    block.call if block
  end

  def addx(n)
    tick
    tick do
      self.x+=n
    end
  end

  def noop
    tick
  end

  def signal_strength
    self.cycle * self.x
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
p cpu.signal_strength_sum
