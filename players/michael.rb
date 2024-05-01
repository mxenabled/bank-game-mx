require "./player"

class Michael < ::Player
  def initialize
    # Don't forget to set your name below
    super("Michael")
  end

  # must return boolean
  def cash_out?(game_state)
    if game_state[:pot_total] > 100
      return true
    else
      return false
    end
  end

  private
  # Add any private methods to help with your strategy.
end
