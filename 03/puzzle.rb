input = File.readlines('input').map(&:strip).reject(&:empty?)

priorities = (('a'..'z').zip(1..26) + ('A'..'Z').zip(27..52)).to_h

sum = 0
input.each_slice(3) do |lines|
  one, two, three = lines.map { |line| line.split('') }
  overlap = (one & two) & three

  sum += priorities[overlap.first]
end
p sum
