require "./player"

class Lameo < ::Player
  def initialize
    super("Lameo")
  end

  # Here is an example of the information you have available
  # in game_state which you can use for your strategy.
  # {
  #   :total_rounds => 10,
  #   :round_number => 5,
  #   :roll_count => 3,
  #   :pot_total => 145,
  #   :last_roll => [3, 2],
  #   :players=> [
  #     [
  #       {
  #         :name => "Dummy",
  #         :score=>524,
  #         :in_the_round => true 
  #       },
  #       {
  #         :name => "Lameo",
  #         :score => 329,
  #         :in_the_round => false
  #       }
  #     ]
  #   ]
  # }

  # must return boolean
  def cash_out?(game_state)
    if game_state[:roll_count] > 3 && game_state[:pot_total] > 100
      return true
    else
      return false
    end
  end
end
