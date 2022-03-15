class Game
  def initialize(players, type)
    @players = DataStructures::LinkedList.new players
    @active_stack = Deck.new
    @winner = nil
    @type = type

    shuffle_and_deal!
  end

  def run_game!
    run_round!
  end

  def run_round!
    round = Round.new(@players)
    round.play do |winner, active_stack|
      winner.hand.add active_stack
    end
    remove_losers!
    check_for_winners!
  end

  private

  def remove_losers!
    losers = @players.filter { |player| player.hand.empty? }
    losers.each { |loser| @players.remove(loser) }
  end

  def check_for_winners!
    @winner = @players.first if @players.size == 1
  end

  def shuffle_and_deal!
    new_shuffled_deck = Deck.new(full: true).shuffle!

    # Currently only testing with 2 + 4 players - don't need to worry about unallocated cards
    # check add method in deck.rb if it is a concern
    @players.each { |player| player.deal_card new_shuffled_deck.draw } until new_shuffled_deck.empty?
  end
end