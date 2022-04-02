# This is pretty gross organizational-wise. But extending the standard LinkedList
# To more optimally check for DeckOfCards Winning conditions
# Also I will be violating SOLID principles here - Sorry CS professors :(
module DeckOfCards
  class LinkedList < DataStructures::LinkedList

    def to_s
      each { |card| puts card.to_s }
    end

    def reflexive_slap?
      doubles? || sandwiches? || tens? || straights? || top_bottom? || marriage?
    end

    def quantitative_slap?(quantity)
      @size >= quantity
    end

    def qualitative_slap?(include_ace)
      contains_face_card?(include_ace)
    end

    private

    def doubles?
      return false unless @size >= 2

      @last.data.rank == @last.previous.data.rank
    end

    def sandwiches?
      return false unless @size >= 3

      @last.data.rank == @last.previous.previous.data.rank
    end

    def tens?
      return false unless @size >= 2

      @last.data.rank.to_i + @last.previous.data.rank.to_i == 10
    end

    def straights?
      return false unless @size >= 3

      arr = [@last.data.rank.to_i, @last.previous.data.rank.to_i, @last.previous.previous.data.rank.to_i].sort
      # Credit https://stackoverflow.com/a/32974038/12817385
      arr.each_cons(2).all? { |a, b| b == a + 1 }
    end

    def top_bottom?
      return false unless @size >= 2

      @first.data.rank == @last.data.rank
    end

    def marriage?
      (@last.data.king? && @last.previous.data.queen?) || (@last.data.queen? && @last.previous.data.king?)
    end

    def contains_face_card?(include_ace)
      if include_ace
        @contains_face_card ||= any?(&:face_card?)
      else
        @contains_face_card ||= any?(&:royal_card?)
      end
    end
  end
end