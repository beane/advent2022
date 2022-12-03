ROCK = 'A'
PAPER = 'B'
SCISSORS = 'C'

LOSE = 'X'
DRAW = 'Y'
WIN = 'Z'

WINNING_MOVES = {
  ROCK => SCISSORS,
  PAPER => ROCK,
  SCISSORS => PAPER
}

MOVE_TO_WIN = WINNING_MOVES.invert

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
    score = score + 6 + SCORES[MOVE_TO_WIN[move]]
  elsif result == DRAW
    score = score + 3 + SCORES[move]
  elsif result == LOSE
    score += SCORES[WINNING_MOVES[move]]
  end
end

pp score
