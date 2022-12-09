def update_tail_pos(h_pos, t_pos)
  hx,hy=h_pos
  tx,ty=t_pos

  y_diff = hy-ty
  x_diff = hx-tx

  if (y_diff.abs == 2 || x_diff.abs == 2) && [x_diff, y_diff].none?(&:zero?)
    x_sign = x_diff / x_diff.abs
    tx = tx + (x_sign)

    y_sign = y_diff / y_diff.abs
    ty = ty + (y_sign)
  elsif y_diff.abs == 2
    y_sign = y_diff / y_diff.abs
    ty = ty + (y_sign)
  elsif x_diff.abs == 2
    x_sign = x_diff / x_diff.abs
    tx = tx + (x_sign)
  end

  [tx,ty]
end

UP = 'U'
LEFT = 'L'
RIGHT = 'R'
DOWN = 'D'

input = File.readlines('input').map &:strip

h_pos = [0,0]
follower_positiions = Array.new(9) { [0,0] }

positions = [follower_positiions.last]

input.each do |line|
  dir, num = line.split(' ')
  count = num.to_i
  if dir == UP
    count.times do
      hx,hy = h_pos
      hy+=1
      h_pos = [hx,hy]
      f_pos = h_pos
      follower_positiions = follower_positiions.map do |t_pos|
        f_pos = update_tail_pos(f_pos, t_pos)
      end

      positions << f_pos
    end
  elsif dir == LEFT
    count.times do
      hx,hy = h_pos
      hx-=1
      h_pos = [hx,hy]
      f_pos = h_pos
      follower_positiions = follower_positiions.map do |t_pos|
        f_pos = update_tail_pos(f_pos, t_pos)
      end

      positions << f_pos
    end
  elsif dir == RIGHT
    count.times do
      hx,hy = h_pos
      hx+=1
      h_pos = [hx,hy]
      f_pos = h_pos
      follower_positiions = follower_positiions.map do |t_pos|
        f_pos = update_tail_pos(f_pos, t_pos)
      end

      positions << f_pos
    end
  elsif dir == DOWN
    count.times do
      hx,hy = h_pos
      hy-=1
      h_pos = [hx,hy]
      f_pos = h_pos
      follower_positiions = follower_positiions.map do |t_pos|
        f_pos = update_tail_pos(f_pos, t_pos)
      end

      positions << f_pos
    end
  end
end

p positions.uniq.count
