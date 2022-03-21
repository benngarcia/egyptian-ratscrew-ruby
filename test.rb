require 'pry'

if __FILE__ == $0
  Dir[File.join(__dir__, 'lib', '**', '*.rb')].sort.each { |file| load file }
  t1 = Time.now
  count = {
    Strategies::REFLEXIVE => 0,
    Strategies::QUALITATIVE => 0
  }
  10_000.times do
    players = [Player.new(Strategies::QUALITATIVE), Player.new(Strategies::REFLEXIVE)]
    winner = Game.new(players, GameTypes::CONTROLLED).run_game!
    count[winner] += 1
  end
  t2 = Time.now
  puts t2 - t1
  puts count
end