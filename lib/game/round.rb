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
  def play_card!
    card = @players.current_player.hand.draw
    if card.nil?
      @players.increment_current!
      return
    elsif card.face_card?
      @sudden_death = true
      @last_face_card_player = @players.current_player
      @turns_remaining = card.turns_left_from_face_card
      @players.increment_current!
    else
      @players.increment_current! unless @sudden_death
    end
    # Yes, this has a different public interface than Deck.... Sowwy :(
    @cards_played.push(*card)

    if @sudden_death && @turns_remaining.zero?
      @winner = @last_face_card_player
      return
    end

    # No more calculations if size < 2
    return if @cards_played.size < 2

    # Returns Array of Players
    slappers = @players.filter { |player| player.slaps_for? @cards_played }

    # I might clean this up - basically checking if the slap was legit
    if @cards_played.reflexive_slap?
      # RoundWinner object only instantiated if winner exists
      @winner = RoundWinner.new(slappers, @game_type).winner
    else
      # burn
      slappers.each { |slapper| @cards_played.unshift(*slapper.hand.draw) }
    end
    @turns_remaining -= 1 if @sudden_death
  end
end 