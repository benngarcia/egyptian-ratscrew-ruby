class Player
  attr_accessor :hand
  attr_reader :strategy

  def initialize(strategy)
    @strategy = strategy
    @hand = Deck.new
    @high_level_strategy = assign_high_level_strategy
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
    case @high_level_strategy
    when :qualitative
      cards_linked_list.qualitative_slap?(Strategies::QUALITATIVE.include_ace?(strategy))
    when :quantitative
      cards_linked_list.quantitative_slap?(Strategies::QUANTITATIVE.num_cards(strategy))
    when :reflexive
      cards_linked_list.reflexive_slap?
    end
  end

  def empty_hand?
    @hand.empty?
  end

  private

  # String comparison can be expensive, if we're simulating millions of games, keep this in memory
  def assign_high_level_strategy
    if strategy.to_s.start_with? 'qualitative'
      :qualitative
    elsif strategy.to_s.start_with? 'quantitative'
      :quantitative
    else
      :reflexive
    end
  end
end