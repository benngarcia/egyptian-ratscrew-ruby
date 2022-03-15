require 'ruby-progressbar'
require 'pry'

if __FILE__ == $0
  Dir[File.join(__dir__, 'lib', '**', '*.rb')].sort.each { |file| load file }
  progressbar = ProgressBar.create total: 100
  10.times do
    players = [Player.new(Strategies::REFLEXIVE), Player.new(Strategies::QUALITATIVE)]
    winner = Game.new(players, GameTypes::CONTROLLED).run_game!
    puts winner
    progressbar.increment
  end
end