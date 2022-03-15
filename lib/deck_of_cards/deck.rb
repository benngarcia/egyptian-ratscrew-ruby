class Deck
  attr_reader :cards
  def initialize(full=true)
    if full
      @cards = Rank::RANKS.flat_map do |rank|
        Suit::SUITS.map do |suit|
          Card.new(rank, suit)
        end
      end
    else
      @cards = []
    end
  end

  def draw
    @cards.pop
  end

  def shuffle!
    @cards.shuffle!
  end

  def sort!
    @cards.sort!
  end
end