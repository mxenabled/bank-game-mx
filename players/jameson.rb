require "./player"

class Jameson < ::Player
  def initialize
    # Don't forget to set your name below
    super("Jameson")
  end

  def cash_out?(game_state)
    if is_game_less_then_half_over(game_state)
      if game_state[:roll_count] > 3 && game_state[:pot_total] > 80
        return true
      else
        return false
      end
    elsif is_game_half_to_three_quarters_over(game_state)
      if game_state[:roll_count] > 3 && game_state[:pot_total] > 120
        return true
      else
        return false
      end
    else
      game_state[:players].each_with_index do |player, i|
        if player[:name] == self.name && i > game_state[:players].length / 2
          if game_state[:roll_count] > 3 && game_state[:pot_total] > 100
            return true
          else
            return false
          end
        else
          if game_state[:roll_count] > 3 && game_state[:pot_total] > 150
            return true
          else
            return false
          end
        end
      end
    end
  end

  private
  def is_game_less_then_half_over(game_state)
    if game_state[:round_number] < game_state[:total_rounds]/2
      return true
    else
      return false
    end
  end

  def is_game_half_to_three_quarters_over(game_state)
    if game_state[:round_number] < ((game_state[:total_rounds]/2)*3) &&  game_state[:round_number] > game_state[:total_rounds]/2
      return true
    else
      return false
    end
  end

end
