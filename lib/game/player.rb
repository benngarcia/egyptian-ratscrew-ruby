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

  def reflexive?
    @strategy == Strategies::REFLEXIVE
  end

  def slaps_for?(cards_linked_list)
    
    case strategy
    when Strategies::REFLEXIVE
      cards_linked_list.reflexive_slap?
    when Strategies::QUALITATIVE
      cards_linked_list.qualitative_slap?
    when Strategies::QUANTITATIVE
      cards_linked_list.qualitative_slap?
    end
  end
end