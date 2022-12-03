input = File.readlines('input').map(&:strip).reject(&:empty?)

priorities = (('a'..'z').zip(1..26) + ('A'..'Z').zip(27..52)).to_h

sum = 0
input.each do |line|
  rucksack = line.split('')
  length = rucksack.length
  one = rucksack.take(length/2)
  two = rucksack.drop(length/2)

  overlap = one & two
  sum += priorities[overlap.first]
end
p sum
