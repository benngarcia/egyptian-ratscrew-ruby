class Rank
  RANKS = %i[
    ace
    king
    queen
    jack
    ten
    nine
    eight
    seven
    six
    five
    four
    three
    two
  ].freeze

  attr_reader :rank

  def initialize(rank)
    @rank = rank
  end

  def <=>(other)
		return 0 if rank == other.rank
		RANKS.index(rank) < RANKS.index(other.rank) ? 1 : -1
  end
end