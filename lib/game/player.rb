class Player
  attr_accessor :hand
  attr_reader :strategy

  def initialize(strategy)
    @strategy = strategy
    @hand = Deck.new
  end

  def deal_card(card)
    @hand.add(card)
  end

  def play_card!
    @hand.draw
  end

  def slaps_for?(cards_linked_list)
    case strategy
    when Strategies::REFLEXIVE
    when Strategies::QUALITATIVE
    when Strategies::QUANTITATIVE
    end
  end
end