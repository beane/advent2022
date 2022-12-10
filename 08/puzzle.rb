def tree_visible?(tree, i, row)
  row[0...i].all? { |el| tree > el } || row[i+1..-1].all? { |el| tree > el }
end

def visible_tree_score(tree, i, row)
  p1 = []
  p2 = []

  row[0...i].reverse.each do |el|
    if tree > el
      p1 << el
    elsif tree <= el
      p1 << el
      break
    end
  end

  row[i+1..-1].each do |el|
    if tree > el
      p2 << el
    elsif tree <= el
      p2 << el
      break
    end
  end

  p1.count * p2.count
end

input = File.readlines('input').map &:strip

grid = []
input.each do |line|
  grid << line.split('').map(&:to_i)
end

inverted = grid.transpose

score = 1
1.upto(input.length-2).each do |i|
  1.upto(input.first.length-2).each do |j|
    tree = grid[i][j]
    temp_score = visible_tree_score(tree, j, grid[i]) * visible_tree_score(tree, i, inverted[j])
    score = temp_score if temp_score > score
  end
end
p score
