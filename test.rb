require 'pry'
require 'objspace'

if __FILE__ == $0
  Dir[File.join(__dir__, 'lib', '**', '*.rb')].sort.each { |file| load file }
  10.times do
    players = [Player.new(Strategies::REFLEXIVE), Player.new(Strategies::QUALITATIVE)]
    winner = Game.new(players, GameTypes::PROBABILISTIC).run_game!
    puts winner
    puts ObjectSpace.each_object(Object).count
  end
end