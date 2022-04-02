class Card
  include Comparable
  attr_reader :rank, :suit

  FACE_SUIT_TURNS = {
    jack: 1,
    queen: 2,
    king: 3,
    ace: 4
  }.freeze

  ROYAL_SUITS = %i[
    jack
    queen
    king
  ].freeze

  def initialize(rank, suit)
    @rank = Rank.new(rank)
    @suit = Suit.new(suit)
  end

  def to_s
    "#{rank.rank} of #{suit.suit}s"
  end

  def ==(other)
    return false unless other.is_a? Card

    rank == other.rank && suit == other.suit
  end

  def <=>(other)
    return 0 if rank == other.rank

    rank < other.rank ? 1 : -1
  end

  # convenience methods

  def king?
    @rank.rank == :king
  end

  def queen?
    @rank.rank == :queen
  end

  def face_card?
    FACE_SUIT_TURNS.keys.include? @rank.rank
  end

  def royal_card?
    ROYAL_SUITS.include? @rank.rank
  end

  def turns_left_from_face_card
    FACE_SUIT_TURNS[@rank.rank]
  end
end