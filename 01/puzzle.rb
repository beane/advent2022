input = File.readlines('input').map(&:strip)

elves = []
calories = 0
input.each do |line|
  if line.empty?
    elves << calories
    calories = 0
  else
    calories += line.to_i
  end
end

pp elves.max
