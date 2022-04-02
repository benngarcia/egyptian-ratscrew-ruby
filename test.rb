require 'pry'

# Dumb
def run_all_sims!(&block)
  all_sims = []
  game_types = [GameTypes::CONTROLLED, GameTypes::PROBABILISTIC]
  # Dumb
  game_types.each do |game_type|
    all_sims.append Simulation.new(game_type).all_faces_2_player
    all_sims.append Simulation.new(game_type).all_faces_4_player
    all_sims.append Simulation.new(game_type).jack_through_king_2_player
    all_sims.append Simulation.new(game_type).jack_through_king_4_player
    all_sims.append Simulation.new(game_type).two_card_slap_2_player
    all_sims.append Simulation.new(game_type).two_card_slap_4_player
    all_sims.append Simulation.new(game_type).three_card_slap_2_player
    all_sims.append Simulation.new(game_type).three_card_slap_4_player
    all_sims.append Simulation.new(game_type).four_card_slap_2_player
    all_sims.append Simulation.new(game_type).four_card_slap_4_player
    all_sims.append Simulation.new(game_type).five_card_slap_2_player
    all_sims.append Simulation.new(game_type).five_card_slap_4_player
    all_sims.append Simulation.new(game_type).six_card_slap_2_player
    all_sims.append Simulation.new(game_type).six_card_slap_4_player
  end

  all_sims.each do |simulation|
    final_stats = simulation.run!
    block.call final_stats, simulation.to_s
  end

  true
end

def run_probablistic_jk_4_player!(&block)
  simulation = Simulation.new(GameTypes::PROBABILISTIC).jack_through_king_4_player
  final_stats = simulation.run!
  block.call final_stats, simulation.to_s
end

def random_test!(&block)
  simulations = [
    Simulation.new(GameTypes::PROBABILISTIC).all_faces_2_player,
    Simulation.new(GameTypes::PROBABILISTIC).all_faces_4_player
  ]

  simulations.each do |simulation|
    final_stats = simulation.run!
    block.call final_stats, simulation.to_s
  end

  true
end

if __FILE__ == $0
  Dir[File.join(__dir__, 'lib', '**', '*.rb')].sort.each { |file| load file }
  random_test! { |count, stringified_simulation| puts "#{stringified_simulation} #{count}" }
end