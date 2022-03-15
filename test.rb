require 'ruby-progressbar'
require 'pry'

if __FILE__ == $0
  Dir[File.join(__dir__, 'lib', '**', '*.rb')].sort.each { |file| load file }
  progressbar = ProgressBar.create total: 1_000_000
  1_000_000.times do
    players = [Player.new(Strategies::REFLEXIVE), Player.new(Strategies::QUALITATIVE)]
    Game.new(players, GameTypes::PROBABILISTIC)
    progressbar.increment
  end
end