class Deck
  attr_reader :cards

  def initialize(full: false)
    if full
      @cards = Rank::RANKS.keys.flat_map do |rank|
        Suit::SUITS.map do |suit|
          Card.new(rank, suit)
        end
      end
    else
      @cards = []
    end
  end

  # If need to sim an amount of cards non-divisible by 52 - spread new_cards.compact
  def add(*new_cards)
    @cards.append(*new_cards)
  end

  def draw
    @cards.shift
  end

  # when player must burn due to improper slap
  def burn(card)
    @cards.unshift(card)
  end

  def shuffle!
    @cards.shuffle!
    self
  end

  def sort!
    @cards.sort!
  end

  def empty?
    @cards.empty?
  end

end
