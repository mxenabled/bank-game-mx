# frozen_string_literal: true

require './player'

# Lu's player
class Greedy < ::Player
  def initialize
    super('Greedy')
  end

  def cash_out?(game_state)
    return true if winner?(game_state)

    false
  end

  private

  def winner?(game_state)
    players = game_state[:players]
    pot_total = game_state[:pot_total]
    greedy_score = 0
    max_player = 0

    players.each do |player|
      greedy_score = player[:score] if player[:name] == 'Greedy'
      score = player[:score]
      max_player = score > max_player ? score : max_player
    end

    pot_total + greedy_score > max_player
  end
end
