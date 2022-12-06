input = File.readlines('input').map &:strip

uniqs = []
index = nil

input[0].chars.each_with_index do |char, i|
  if uniqs.include? char
    # drop everything up to and including the first dup from uniqs list
    dup_index = uniqs.find_index(char)
    uniqs = uniqs.drop(dup_index+1)
    index = nil
  end

  uniqs << char

  if uniqs.length == 14
    index = i
    break
  end
end

p index + 1
