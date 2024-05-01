require "./player"

class Logan < ::Player
  def initialize
    # Don't forget to set your name below
    super("Logan")
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
  #       :name => "Logan",
  #       :score => 0,
  #       :in_the_round => true
  #       }
  #     ],
  #   # other_players is all players other than yourself and it's in descending 
  #   # order where the person currently winning is at the top.
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
    if game_state[:roll_count] > 3 && (
       game_state[:roll_count] > 10 ||
       game_state[:pot_total] > 250 ||
       players_have_cashed_out?(game_state[:other_players])
       )
      return true
    else
      return false
    end
  end

  def players_have_cashed_out?(players)
    # [1,2,3,4,5].select {|num| num.even? }
    return players.select {|player| !player[:in_the_round]}.length > 0
  end

  private
  # Add any private methods to help with your strategy.
end
