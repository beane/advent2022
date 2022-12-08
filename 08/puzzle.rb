def tree_visible?(tree, i, row)
  row[0...i].all? { |el| tree > el } || row[i+1..-1].all? { |el| tree > el }
end

input = File.readlines('input').map &:strip

grid = []
input.each do |line|
  grid << line.split('').map(&:to_i)
end

inverted = grid.transpose

count = 0
1.upto(input.length-2).each do |i|
  1.upto(input.first.length-2).each do |j|
    tree = grid[i][j]
    count += 1 if tree_visible?(tree, j, grid[i]) || tree_visible?(tree, i, inverted[j])
  end
end
p count + (2 * grid.length) + 2 * (grid.first.length - 2)
