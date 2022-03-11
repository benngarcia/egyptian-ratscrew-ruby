class Suit
	SUIT = %i[
    spade
    heart
    diamond
    club
  ].freeze

	attr_reader :suit
  def initialize(suit)
		@suit = suit
  end

  def <=>(other)
		return 0 if suit == other.suit
		SUITS.index(suit) < SUITS.index(other.suit) ? 1 : -1
  end
end