require 'colorize'

require_relative "player"
require_relative "round"
require("pry")

class Game
  attr_reader :players
  attr_accessor :previous_rounds

  # loads all the players from the players directory
  def initialize(total_rounds: 15, slow_mode: false)
    @players = []
    Dir["players/*.rb"].each do |file_path|
      file_name = File.basename(file_path, ".rb")
      require "./players/#{file_name}"
      class_name = file_name.gsub(/^[a-z0-9]|_[a-z0-9]/){ |a| a.upcase }.gsub(/_/,"")
      @players << Object.const_get(class_name).new
    end
    @total_rounds = total_rounds
    @round_number = 0
    @previous_rounds = []
    @slow_mode = slow_mode
  end

  def game_state
    {
      total_rounds: @total_rounds,
      round_number: @round_number,
      roll_count: @current_round&.roll_count || 0,
      pot_total: @current_round&.pot_total || 0,
      last_roll: @current_round&.roll_history&.last,
      players: players_leader_board.map do |player|
        {
          name: player.name,
          score: player.score,
          in_the_round: @current_round&.active_players&.include?(player)
        }
      end
    }
  end

  def start
    game_over = false
    start_message if @slow_mode
    while @round_number < @total_rounds
      @round_number += 1
      new_round_message if @slow_mode
      @current_round = Round.new(@round_number, @players)
      while @current_round.round_over? == false do
        @current_round.roll_the_dice
        roll_message if @slow_mode
        check_if_players_want_to_cash_out
      end
      @previous_rounds << @current_round
    end
    game_summary_message if @slow_mode
  end

  def summary
    sorted_players = players_leader_board
    leader_board = sorted_players.each_with_index.map { |player, i| "#{i+1}: #{player.name} - #{player.score}" }
  end

  def players_leader_board
    @players.sort_by { |player| player.score }.reverse
  end

  private

  def check_if_players_want_to_cash_out
    pre_roll_game_state = game_state
    players_cashing_out = @current_round.active_players.select { |player| player._cash_out?(pre_roll_game_state) }
    players_cashing_out.each do |player|
      player.score += @current_round.pot_total
    end
    @current_round.active_players -= players_cashing_out
    cash_out_message(players_cashing_out) if @slow_mode
  end

  def cash_out_message(players_out)
    return if players_out.empty?
    puts "#{players_out.map(&:name).join(", ")} decided to cash out".colorize(:green)
    puts "Their score is locked in at:".colorize(:green)
    puts players_out.map { |player| "#{player.name}: $#{player.score}".colorize(:green) }
    sleep(1.3)
  end

  def game_summary_message
    puts "\nGAME OVER"
    puts "Leaderboard:"
    puts players_leader_board.each_with_index.map { |player, i| "#{i+1}: #{player.name} - #{player.score}" }
  end

  def new_round_message
    puts "\nStarting round ##{@round_number} of #{@total_rounds}".underline
    puts "Leaderboard:"
    puts players_leader_board.each_with_index.map { |player, i| "#{i+1}: #{player.name} - #{player.score}" }
    puts "-----------------------"
  end

  def start_message
    puts "Starting a game of #{@total_rounds} with #{@players.count} players."
    sleep(2)
  end

  def roll_message
    puts "Dice rolled are " + "#{@current_round&.roll_history&.last&.first}".colorize(:light_blue) + " and " + "#{@current_round&.roll_history&.last&.last}".colorize(:light_blue)
    if @current_round&.roll_count > 3 && @current_round&.roll_history&.last.sum == 7
      puts "Bust!".colorize(:red)
    else
      puts "The pot is " + "$#{@current_round&.pot_total}".colorize(:green).underline
    end
    sleep(1.3)
  end
end
