# frozen_string_literal: true

require './player'

# Lu's player
class Naive < ::Player
  def initialize
    super('Naive')
  end

  def cash_out?(_)
    true
  end
end
