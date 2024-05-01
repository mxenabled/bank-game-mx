require "./player"

class Tyson < ::Player
  def initialize
    # Don't forget to set your name below
    super("Tyson")
  end

  # must return boolean
  def cash_out?(game_state)
    if game_state[:roll_count] > 3
      if game_state[:last_roll][0] == game_state[:last_roll][1]
        return true
      else
        return false
      end
    else
      return false
    end
  end

  private
  # Add any private methods to help with your strategy.
end
