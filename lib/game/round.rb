# Conceptually, this object represents the incrementing of a given round - a round starts when a new card is played
# + stops when someone successfully slaps
class Round
  def initialize(players)
    @players = players
    @cards_played = DeckOfCards::LinkedList.new
  end

  def play(&block)
    play_card!

    block.call winner, @cards_played.to_a
  end

  private

  def play_card!
    card = @players.current_player.hand.draw
    @players.increment_current!
    return if card.nil? # Move to next player if current player has no cards left

    # Yes, this has a different public interface than Deck.... Sowwy :(
    @cards_played.push card
    
    # No more calculations if size < 2
    return if @cards_played.size < 2
    
    slappers = @players.filter { |player| player.slaps_for? @cards_played }
  end

  def check_for_slap!
  end

end 