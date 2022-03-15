# Conceptually, this object represents the incrementing of a given round - a round starts when a new card is played
# + stops when someone successfully slaps
class Round
  def initialize(players, game_type)
    @players = players
    @cards_played = DeckOfCards::LinkedList.new
    @game_type = game_type
  end

  def play(&block)
    play_card! until @winner
    block.call @winner, @cards_played.to_a
  end

  private

  def play_card!
    card = @players.current_player.hand.draw
    @players.increment_current!
    return if card.nil? # Move to next player if current player has no cards left

    # Yes, this has a different public interface than Deck.... Sowwy :(
    @cards_played.push(*card)

    # No more calculations if size < 2
    return if @cards_played.size < 2

    # Returns Array of Players
    slappers = @players.filter { |player| player.slaps_for? @cards_played }

    return if slappers.empty?

    # I might clean this up - basically checking if the slap was legit
    if @cards_played.reflexive_slap?
      # RoundWinner object only instantiated if winner exists
      @winner = RoundWinner.new(slappers, @game_type).winner
    else
      # burn
      slappers.each { |slapper| @cards_played.unshift(*slapper.hand.draw) }
    end
  end

end 