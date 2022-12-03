ROCK = 'A'
PAPER = 'B'
SCISSORS = 'C'

LOSE = 'X'
DRAW = 'Y'
WIN = 'Z'

LOSING_MOVES = {
  ROCK => SCISSORS,
  PAPER => ROCK,
  SCISSORS => PAPER
}

WINNING_MOVES = LOSING_MOVES.invert

SCORES = {
  ROCK => 1,
  PAPER => 2,
  SCISSORS => 3,
}

input = File.readlines('input').map(&:strip).reject(&:empty?)

score = 0
input.each do |line|
  move, result = line.split(' ')

  if result == WIN
    score = score + 6 + SCORES[WINNING_MOVES[move]]
  elsif result == DRAW
    score = score + 3 + SCORES[move]
  elsif result == LOSE
    score += SCORES[LOSING_MOVES[move]]
  end
end

pp score
