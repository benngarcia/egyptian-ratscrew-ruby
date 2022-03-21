require 'pry'

if __FILE__ == $0
  Dir[File.join(__dir__, 'lib', '**', '*.rb')].sort.each { |file| load file }
  t1 = Time.now
  10_000.times do
    players = [Player.new(Strategies::REFLEXIVE), Player.new(Strategies::QUALITATIVE)]
    winner = Game.new(players, GameTypes::PROBABILISTIC).run_game!
  end
  t2 = Time.now
  puts t2-t1
end