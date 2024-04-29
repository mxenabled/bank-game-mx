class Player
  attr_reader :name
  attr_accessor :score

  def initialize(name)
    raise "Name cannot be nil" if name.nil?
    @name = name
    @score = 0
  end

  def cash_out?(game_state)
    # must return boolean
  end

  def _cash_out?(game_state)
    gs = game_state.clone
    other_players = filtered_players_list(game_state)
    gs[:other_players] = other_players
    cash_out?(gs)
  end

  private

  # Returns players excluding thyself
  def filtered_players_list(game_state)
    game_state[:players].reject { |player| player[:name] == name }
  end
end
