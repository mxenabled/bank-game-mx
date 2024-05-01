require "./player"

class Ashley < ::Player
  def initialize
    super("Ashley")
  end

  # must return boolean
  def cash_out?(game_state)
    if game_state[:roll_count] > 3 && game_state[:pot_total] > 120 && (self.score < game_state[:other_players][0][:score]) 
      return true
    else
      return false
    end
  end
end
