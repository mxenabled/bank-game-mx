require_relative "game"
require_relative "game_series"

# Run a game 
# g1 = Game.new(total_rounds: 15)
# g1.start
# puts g1.summary

# Run a game in slow mode to spectate the game in action
# g1 = Game.new(total_rounds: 10, slow_mode: true)
# g1.start

# Run a game series and view the results
gs = GameSeries.new(total_games: 100, rounds: 15)
gs.run
gs.print_summary
