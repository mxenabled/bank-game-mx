require_relative "dice"

class Round
  attr_accessor :active_players, :round_number, :roll_count, :pot_total, :roll_history

  def initialize(round_number, players)
    @roll_count = 0
    @active_players = players
    @pot_total = 0
    @dice1 = Dice.new
    @dice2 = Dice.new
    @roll_history = []
  end

  def roll_the_dice
    @roll_count += 1
    roll_value1 = @dice1.roll
    roll_value2 = @dice2.roll
    @roll_history << [roll_value1, roll_value2]
    @pot_total += get_roll_result(roll_value1, roll_value2)
  end

  def round_over?
    @active_players.empty?
  end

  private

  def get_roll_result(dice1_value, dice2_value)
    added_score = dice1_value + dice2_value
    if @roll_count <= 3
      if added_score == 7
        return 70
      else
        return added_score
      end
    else # in the danger zone
      if added_score == 7
        @active_players = []
        @pot_total = 0
        return 0 # I guess 0 means bust
      elsif dice1_value == dice2_value
        return @pot_total
      else
        return added_score
      end
    end
  end
end
