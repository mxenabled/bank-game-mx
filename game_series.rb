require_relative "game"

class GameSeries
  attr_reader :results, :leader_board

  def initialize(total_games: 100, rounds: 15)
    @total_games = total_games
    @results = {}
  end

  def run
    @total_games.times do
      game = Game.new(total_rounds: 10, slow_mode: false)
      game.start
      update_results(game.players_leader_board)
    end
  end

  def stats
    @stats ||= begin
      total_players = @results.keys.length
      @results.each do |player_name, data|
        scores = data[:scores]
        placements = data[:placements]

        win_rate = placements.count(0).to_f / placements.length.to_f
        avg_score = scores.sum(0.0) / scores.size
        placement_score = placements.reduce(0) { |sum, place| sum + (total_players - 1 - place) }

        @results[player_name][:win_rate] = win_rate
        @results[player_name][:avg_score] = avg_score
        @results[player_name][:placement_score] = placement_score
      end
    end
  end

  def summary
    sorted_players = stats.map do |name, data|
      {player_name: name}.merge(data)
    end.sort_by { |player| player[:win_rate] }.reverse
    @leader_board = sorted_players.each_with_index.map { |player, i| "#{i+1}: #{ player[:player_name] } - win_rate: #{ player[:win_rate] * 100 }% placements_score: #{ player[:placement_score] } average_end_game_$$: #{ player[:avg_score] }" }
  end

  def print_summary
    puts summary
  end

  private

  def update_results(players_leader_board)
    players_leader_board.each_with_index do |player, i|
      if @results.key?(player.name)
        @results[player.name][:scores].push(player.score)
        @results[player.name][:placements].push(i)
      else
        @results[player.name] = { scores: [ player.score ], placements: [i] }
      end
    end
  end

end
