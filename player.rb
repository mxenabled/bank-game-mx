class Player
  attr_reader :name
  attr_accessor :score

  def initialize(name)
    @name = name
    @score = 0
  end

  def cash_out?(game_state)
    # must return boolean
  end

  private

  # you can add any private methods here to do logic and strategy
end
