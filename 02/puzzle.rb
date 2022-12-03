ROCK = 'X'
PAPER = 'Y'
SCISSORS = 'Z'

RPS = {
  'A' => ROCK,
  'B' => PAPER,
  'C' => SCISSORS
}

WINNING_MOVES = {
  ROCK => SCISSORS,
  PAPER => ROCK,
  SCISSORS => PAPER
}

SCORES = {
  ROCK => 1,
  PAPER => 2,
  SCISSORS => 3,
}

input = File.readlines('input').map(&:strip).reject(&:empty?)

def win?(move1, move2)
  WINNING_MOVES[move2] == RPS[move1]
end

def draw?(move1, move2)
  move2 == RPS[move1]
end

def lose?(move1, move2)
  WINNING_MOVES[RPS[move1]] == move2
end

score = 0
input.each do |line|
  move1, move2 = line.split(' ')
  if win?(move1, move2)
    score = score + 6 + SCORES[move2]
  elsif draw?(move1, move2)
    score = score + 3 + SCORES[move2]
  elsif lose?(move1, move2)
    score = score + 0 + SCORES[move2]
  end
end

pp score
