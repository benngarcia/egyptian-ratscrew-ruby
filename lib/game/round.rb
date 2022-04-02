# Conceptually, this object represents the incrementing of a given round - a round starts when a new card is played
# + stops when someone successfully slaps
class Round
  def initialize(players, game_type)
    @players = players
    @cards_played = DeckOfCards::LinkedList.new
    @game_type = game_type
    @sudden_death = false
  end

  def play(&block)
    play_card! until @winner

    block.call @winner, @cards_played.to_a
  end

  private

  # This is literally so gross lol - sorry if you're trying to understand what's going on.
  # In lieu of good code design, comments will do :')
  def play_card!

    # Player "draws" card
    card = @players.current_player.hand.draw

    # If the players hand is empty, calling .draw will return nil. So, move to the next player.
    if card.nil?
      @players.increment_current!
      return
    elsif card.face_card?
      # Enter sudden death
      @sudden_death = true
      # keep track of last player who started sudden death
      @last_face_card_player = @players.current_player

      # keep track of turns remaining
      @turns_remaining = card.turns_left_from_face_card
      @players.increment_current!
    else
      # Don't increment if sudden death is being played
      @players.increment_current! unless @sudden_death
    end
    # Yes, this has a different public interface than Deck.... Sowwy :(
    # Add card drawn to stack
    @cards_played.push(*card)

    # At this point - if it was the last card of sudden death, we assign the winner without checking slap conditions.
    # This is noted in paper.
    if @sudden_death && @turns_remaining.zero?
      @winner = @last_face_card_player
      return
    end

    # No more calculations if size < 2
    return if @cards_played.size < 2

    # Returns Array of Players who will slap for last card played
    slappers = @players.filter { |player| player.slaps_for? @cards_played }

    # If slap is legit slap (i.e. if a reflexive player would slap) assign a RoundWinner
    # else, slappers must burn
    if @cards_played.reflexive_slap?
      
      # Too lazy to implement LinkedList#partition :p
      non_slappers = []
      non_slappers = @players.filter { |player| !player.slaps_for?(@cards_played) } if @game_type == GameTypes::PROBABILISTIC

      # RoundWinner object only instantiated if winner exists
      @winner = RoundWinner.new(slappers, @game_type, non_slappers).winner
    else
      # burn
      slappers.each { |slapper| @cards_played.unshift(*slapper.hand.draw) }
    end
    @turns_remaining -= 1 if @sudden_death
  end
end