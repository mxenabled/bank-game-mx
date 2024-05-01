# frozen_string_literal: true

require './player'

# Lu's player
class Twopzy < ::Player
  def initialize
    super('Twopzy')
  end

  def cash_out?(game_state)
    return true if game_state[:pot_total] > 200

    false
  end
end
