input = File.readlines('input').map(&:strip)

count = 0
input.each do |line|
  pair1, pair2 = line.split(',')
  a,b = pair1.split('-').map(&:to_i)
  x,y = pair2.split('-').map(&:to_i)

  count += 1 if (a.between?(x,y) && b.between?(x,y)) || (x.between?(a,b) && y.between?(a,b))
end

pp count
