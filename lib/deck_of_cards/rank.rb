class Rank
  include Comparable
  RANKS = {
    ace: 1,
    two: 2,
    three: 3,
    four: 4,
    five: 5,
    six: 6,
    seven: 7,
    eight: 8,
    nine: 9,
    ten: 10,
    jack: 11,
    queen: 12,
    king: 13
  }.freeze

  attr_reader :rank

  def initialize(rank)
    @rank = rank
  end

  def to_i
    
  end

  def <=>(other)
    return 0 if rank == other.rank

    RANKS[rank] < RANKS[other.rank] ? 1 : -1
  end
end