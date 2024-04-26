require "./player"

class Lameo < ::Player
  def initialize
    super("Lameo")
  end

  # must return boolean
  def cash_out?(game_state)
    if game_state[:roll_count] > 3 && game_state[:pot_total] > 100
      return true
    else
      return false
    end
  end
end
