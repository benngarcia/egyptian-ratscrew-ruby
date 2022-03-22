module Strategies
  module QUALITATIVE
    ALL_FACES = :qualitative_all_faces
    JACK_THROUGH_KING = :qualitative_j_k

    def include_ace?(strategy)
      case strategy
      when ALL_FACES then true
      when JACK_THROUGH_KING then false
      end
    end
    module_function :include_ace?
  end

  module QUANTITATIVE
    TWOCARD = :quantitative_2_card
    THREECARD = :quantitative_3_card
    FOURCARD = :quantitative_4_card
    FIVECARD = :quantitative_5_card
    SIXCARD = :quantitative_6_card

    def num_cards(strategy)
      case strategy
      when TWOCARD then 2
      when THREECARD then 3
      when FOURCARD then 4
      when FIVECARD then 5
      when SIXCARD then 6
      end
    end
    module_function :num_cards
  end

  REFLEXIVE = :reflexive
end