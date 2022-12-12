class Monkey
  attr_accessor :items, :inspection_count
  attr_reader :operation_string, :div_test, :friend1, :friend2
  def initialize(items, operation_string, div_test, friend1, friend2)
    @items=items
    @operation_string=operation_string
    @div_test=div_test
    @friend1=friend1
    @friend2=friend2
    @inspection_count=0
  end

  def take_turn(monkeys)
    until items.empty?
      item = items.shift
      new_wl = self.inspection_worry_level(item)
      monkeys[self.monkey_to(new_wl)].items << new_wl
      self.inspection_count += 1
    end
  end

  def inspection_worry_level(item)
    operand1, operation, operand2 = self.operation_string.split(' ')
    a = operand1=='old' ? item : operand1.to_i
    b = operand2=='old' ? item : operand2.to_i
    if operation == '*'
      (a*b)/3
    elsif operation == '+'
      (a+b)/3
    end
  end

  def monkey_to(worry_level)
    (worry_level % div_test == 0) ? friend1 : friend2
  end
end

MONKEYS = []

input = File.readlines('inputt').map &:strip

input.each_slice(7) do |monkey_data|
  monkey_data = monkey_data.take(6)
  index = monkey_data[0][-2].to_i
  starting_items = /^Starting items: ([\d, ]+)/.match(monkey_data[1])
    .captures
    .first
    .split(', ')
    .map(&:to_i)
  operation_string = monkey_data[2].split(' = ').last
  div_test = /(\d+$)/.match(monkey_data[3]).captures.first.to_i
  true_test = /throw to monkey (\d+)$/.match(monkey_data[4])
    .captures
    .first
    .to_i
  false_test = /throw to monkey (\d+)$/.match(monkey_data[5])
    .captures
    .first
    .to_i
  MONKEYS[index.to_i] = Monkey.new(starting_items, operation_string, div_test, true_test, false_test)
end

20.times do
  MONKEYS.each do |monkey|
    monkey.take_turn(MONKEYS)
  end
end

pp MONKEYS.sort_by { |m| m.inspection_count }.last(2).map(&:inspection_count).reduce(&:*)
