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
    return true if cards_linked_list.reflexive_slap?

    if strategy.to_s.start_with? 'qualitative'
      cards_linked_list.qualitative_slap?(Strategies::QUALITATIVE.include_ace?(strategy))
    elsif strategy.to_s.start_with? 'quantitative'
      cards_linked_list.quantitative_slap?(Strategies::QUANTITATIVE.num_cards(strategy))
    end
  end
end