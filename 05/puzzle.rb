input = File.readlines('input').map &:chomp

crate_list = input.take_while { |line| !line.empty? }
crates = crate_list[0...-1]

stack_list = crate_list.last
num_stacks = stack_list.split.last.to_i
stacks = Array.new(num_stacks) { [] }

instructions = input.drop_while { |line| !line.empty? }.drop(1)

def parse_crate(crate)
  return nil if crate.chars.all? { |char| char == " " }
  crate
end

crates.each do |crate|
  num_stacks.times do |i|
    stacks[i].unshift parse_crate(crate[i*4+1])
  end
end
stacks = stacks.map { |stack| stack.compact }

instructions.each do |instruction|
  _, n, _, from, _, to = instruction.split.map(&:to_i)

  stacks[to-1] += stacks[from-1].last n
  stack_height = stacks[from-1].length
  stacks[from-1] = stacks[from-1].take(stack_height-n)
end

puts stacks.map(&:last).join
