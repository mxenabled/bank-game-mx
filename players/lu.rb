# frozen_string_literal: true

require './player'

# Lu's player
class Lu < ::Player
  def initialize
    super('Lu')
  end

  def cash_out?(game_state)
    return true if rounds_gt(game_state, 3) && double?(game_state[:last_roll])

    false
  end

  private

  def double?(last_rollout)
    return true if last_rollout[0] == last_rollout[1]

    false
  end

  def rounds_gt(game_state, round)
    return true if game_state[:total_rounds] > round

    false
  end
end
