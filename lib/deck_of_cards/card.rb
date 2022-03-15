class Card
  include Comparable
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = Rank.new(rank)
    @suit = Suit.new(suit)
  end

  def ==(other)
    return false unless other.is_a? Card

    rank == other.rank && suit == other.suit
  end

  def <=>(other)
    return 0 if rank == other.rank

    rank < other.rank ? 1 : -1
  end
end