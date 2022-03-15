# This is pretty gross organizational-wise. But extending the standard LinkedList
# To optimally check for DeckOfCards Winning conditions
# Also I will be violating SOLID principles here - Sorry CS professors :(
class DeckOfCards::LinkedList < DataStructures::LinkedList

  def reflexive_slap?
    doubles? || sandwiches? || tens? || straights? || top_bottom? || marriage?
  end
  
  private

  def doubles?
    return false unless @size >= 2

    @last.data == @last.previous.data
  end

  def sandwiches?
    return false unless @size >= 3

    @last.data == @last.previous.previous.data
  end

  def tens?
    return false unless @size >= 2

    @last.data
  end
end