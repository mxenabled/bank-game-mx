# frozen_string_literal: true

require './player'

# Lu's player
class Trixy < ::Player
  def initialize
    super('Trixy')
  end

  def cash_out?(game_state)
    return true if game_state[:pot_total] > 300

    false
  end
end

