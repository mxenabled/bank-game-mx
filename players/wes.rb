require "./player"

class Wes < ::Player
  def initialize
    super("Wes")
  end

  def will_banking_put_me_in_the_lead(game_state)
    return game_state[:pot_total] + self.score > game_state[:players][0][:score]
  end

  # must return boolean
  def cash_out?(game_state)
    if game_state[:roll_count] > 3 && game_state[:pot_total] > 50 && will_banking_put_me_in_the_lead(game_state)
      return true
    elsif game_state[:roll_count] > 3 && game_state[:pot_total] > 150
      return true
    else
      return false
    end
  end

  private
end
