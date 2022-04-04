require 'optparse'
require 'pry'
require './lib/game/simulation.rb'

namespace :game do |args|
  desc 'Simulate some games with given flags: rake game:simulate'
  task :simulate do
    Dir[File.join(__dir__, 'lib', '**', '*.rb')].sort.each { |file| load file }
    options = {}
    OptionParser.new(args) do |opts|
      opts.banner = 'Usage: rake game:simulate [options]'
      opts.on('--playercount=PLAYERCOUNT', 'Number of players', Integer) do |player_count|
        options[:player_count] = player_count
      end
      opts.on('--gameiterations=GAMEITERATIONS', 'Number of games simulated.', Integer) do |game_iterations|
        options[:game_iterations] = game_iterations
      end
      opts.on('--probablistic=PROBABLISTIC', 'Enable Probablistic Game', String) do |probablistic|
        options[:probablistic] = (probablistic.to_s.downcase == 'true')
      end
      opts.on('-sp', '--specialplayers=SPECIALPLAYERS', 'put Array of Special Players to be included', Array) do |special_players|
        options[:special_players] = special_players
      end
      opts.on('-h', '--help', "Help") do
        puts opts
        exit
      end
    end.parse!(ARGV[2..-1])

    simulation_type = options[:probablistic] ? GameTypes::PROBABILISTIC : GameTypes::CONTROLLED

    player_count = options[:player_count]

    iteration_count = options[:game_iterations]

    special_players = options[:special_players].map { |player| Object.const_get player }

    if special_players.size > player_count
      puts "too many special players"
      exit 1
    end

    if iteration_count.nil?
      simulation = Simulation.new(sim_type: simulation_type, strategies: special_players, player_count: player_count)
    else
      simulation = Simulation.new(sim_type: simulation_type, strategies: special_players, player_count: player_count, iteration_count: iteration_count)
    end

    final_stats = simulation.run!
    puts "#{simulation.to_s} #{final_stats}"
    exit
  end
end