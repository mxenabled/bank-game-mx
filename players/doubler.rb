# frozen_string_literal: true

require './player'

# Lu's player
class Doubler < ::Player
  def initialize
    super('Doubler')
  end

  def cash_out?(game_state)
    return true if double_max_points?(game_state)

    false
  end

  private

  def double_max_points?(game_state)
    players = game_state[:players]
    pot_total = game_state[:pot_total]
    max_player = 0

    players.each do |player|
      score = player[:score]
      max_player = score > max_player ? score : max_player
    end

    return true if pot_total > 2 * max_player

    false
  end
end
