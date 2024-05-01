require_relative "game"

require("colorize")

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

        win_rate = placements.count(0).to_f / placements.length.to_f * 100
        avg_score = scores.sum(0.0) / scores.size
        placement_score = placements.reduce(0) { |sum, place| sum + (total_players - 1 - place) }
        total_money_won = scores.sum

        @results[player_name][:win_rate] = win_rate.round(1)
        @results[player_name][:avg_score] = avg_score.round(2)
        @results[player_name][:placement_score] = placement_score
        @results[player_name][:total_money_won] = total_money_won
      end
    end
  end

  def summary
    sorted_players = stats.map do |name, data|
      {player_name: name}.merge(data)
    end.sort_by { |player| player[:win_rate] }.reverse
    @leader_board = sorted_players.each_with_index.map { |player, i| "#{i+1}: #{ player[:player_name] } - win_rate: " + "#{ player[:win_rate] }%".colorize(:light_blue) + " placements_score: " + "#{ player[:placement_score] }".colorize(:red) + " average_end_game_$$: " + "$#{ player[:avg_score] }".colorize(:green) + " total_money_won: " + "$#{ player[:total_money_won] }".colorize(:green) }
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
