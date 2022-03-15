# Conceptually, this object represents the incrementing of a given round - a round starts when a new card is played
# + stops when someone successfully slaps
class Round
  def initialize(players)
    @players = players
    @cards_played = Deck.new
  end

  def play(&block)

    block.call winner, cards
  end

end 