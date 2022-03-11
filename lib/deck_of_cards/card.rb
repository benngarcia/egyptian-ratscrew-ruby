class Card
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def ==(other)
    return false unless other.is_a? Card
    rank == other.rank && suit == other.suit
  end
end