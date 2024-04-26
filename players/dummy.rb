require "./player"

class Dummy < ::Player
  def initialize
    super("Dummy")
  end

  # {
  #   :total_rounds => 10,
  #   :round_number => 1,
  #   :roll_count => 1,
  #   :pot_total => 10,
  #   :last_roll => [5, 5],
  #   :players => [
  #     { 
  #       :name => "Lameo",
  #       :score => 0,
  #       :in_the_round => true
  #     },
  #     { 
  #       :name => "Dummy",
  #       :score => 0,
  #       :in_the_round => true
  #       }
  #     ],
  #   :other_players => [
  #     {
  #       :name => "Lameo",
  #       :score => 0,
  #       :in_the_round => true
  #     }
  #   ]
  # }

  # must return boolean
  def cash_out?(game_state)
    if game_state[:roll_count] > 5
      return true
    else
      return false
    end
  end

  private
  # Add any private methods to help with your strategy.
end
