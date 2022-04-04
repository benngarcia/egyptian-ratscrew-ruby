# Credit base with https://github.com/blahah/datastructures/blob/master/lib/datastructures/linked_list.rb
# Implements a doubly Linked List.
module DataStructures
  class LinkedList

    class LLNode
      attr_accessor :data, :next, :previous

      def initialize(data, next_item, previous)
        @data = data
        @next = next_item
        @previous = previous

      end

      def ==(other)
        return false unless other.is_a? LLNode

        data == other.data && @next == other.next
      end
    end


    attr_accessor :first, :last, :size
    attr_reader :current

    alias length size

    # Returns a new LinkedList
    #
    # If no arguments are sent, the new LinkedList will be empty.
    # When one or more objects are sent as arguments, the LinkedList
    # is populated with those objects in the order sent.
    def initialize(*entries)
      @size = 0
      return if entries.empty?

      @first = LLNode.new(entries.shift, nil, nil)
      @current = @first
      @last = @first
      @size = 1
      push(*entries) unless entries.empty?
    end

    # Returns true if the LinkedList is empty
    def empty?
      @size == 0
    end

    def increment_current!
      if @current == @last
        @current = @first
      else
        @current = @current.next
      end
    end

    # Convenience method
    def current_player
      @current.data
    end

    # Element Reference - Returns the element at +index+
    def [](index)
      temp_current = @first
      index.times do
        temp_current = temp_current.next
      end
      temp_current.data
    end

    # Element Assignment - Sets the element at +index+ to
    # +:data+
    def []=(index, data)
      if index > @size - 1
        # fill in the gaps
        ((index - @size) + 1).times do
          push nil
        end
        @last.data = data
      else
        # replace existing value
        temp_current = @first
        index.times do
          temp_current = temp_current.next
        end
        temp_current.data = data
      end
      self
    end

    # Insert a node with +:data+ at +:index+.
    # All nodes +:index+ and above get moved along one.
    def insert(index, data)
      old_node = @first
      return unshift(data) if index.zero?
      return push(data) if index == @size

      index.times do
        old_node = old_node.next
      end
      new_node = LLNode.new(data, old_node, old_node.previous)
      old_node.previous.next = new_node
      old_node.previous = new_node
      self
    end

    # Delete the node at +:index+
    def delete(index)
      temp_current = @first

      if index.zero?
        increment_current! if @current == @first
        return shift
      end

      if index == (@size - 1)
        increment_current! if @current == @last
        return pop
      end

      index.times do
        temp_current = temp_current.next
      end
      increment_current! if @current == temp_current
      @size -= 1
      temp_current.previous.next = temp_current.next
      temp_current.next.previous = temp_current.previous
    end

    # Calls the given block once for each element in +self+, passing
    # that element as a parameter
    # I'm sad I forgot I could just include the Enumerable module
    # Since I defined an each method. Rookie mistake :(
    def each(&block)
      temp_current = @first
      @size.times do
        block.call temp_current.data
        temp_current = temp_current.next
      end
    end

    def filter(&block)
      temp_arr = []
      temp_current = @first
      @size.times do
        filter = block.call temp_current.data
        temp_arr.append(temp_current.data) if filter
        temp_current = temp_current.next
      end
      temp_arr
    end

    def any?(&block)
      temp_current = @first
      is_truthy = false
      @size.times do
        is_truthy ||= block.call temp_current.data
        temp_current = temp_current.next
      end
      is_truthy
    end

    # 
    def any_but_last?(&block)
      temp_current = @first
      is_truthy = false
      (@size - 1).times do
        is_truthy ||= block.call temp_current.data
        temp_current = temp_current.next
      end
      is_truthy
    end

    # Append - Pushes the given object(s) on to the end of this
    # Linked List. The expression returns the list itself, so several
    # appends may be chained together. See also #pop for the opposite effect.
    def push(*elements)
      elements.compact.each do |element|
        node = LLNode.new(element, nil, @last)
        @first = node if @first.nil?
        @last.next = node unless @last.nil?
        @last = node
        @size += 1
      end
      self
    end

    alias :<< :push

    # Removes the last element from +self+ and returns it.
    # Raises an underflow error if empty.
    def pop
      raise "Linked List underflow: nothing to pop." if self.size == 0
      last = @last
      @last = @last.previous
      @size -= 1
      last.data
    end

    # Prepends objects to the front of +self+, moving other elements
    # upwards. See also #shift for the opposite effect.
    def unshift(*elements)
      elements.compact.each do |element|
        node = LLNode.new(element, @first, nil)
        @last = node if @last.nil?
        @first.previous = node unless @first.nil?
        @first = node
        @size += 1
      end
      self
    end

    # Removes the first element of self and returns it (shifting all
    # other elements down by one.
    def shift
      raise "Linked List underflow: nothing to shift." if self.size == 0
      first = @first
      @first = @first.next
      @size -= 1
      first.data
    end

    # Returns the first index equal to +data+ (using == comparison).
    # Counts from the beginning of the list.
    def index(data)
      temp_current = @first
      i = 0
      until temp_current.nil?
        return i if temp_current.data == data

        temp_current = temp_current.next
        i += 1
      end
      nil
    end

    def remove(data)
      index = index(data)
      delete(index)
    end

    # Returns an array containing the data from the nodes in the list
    def to_a
      temp_current = @first
      array = []
      until temp_current.nil?
        array << temp_current.data
        temp_current = temp_current.next
      end
      array
    end

    # Returns a string representation of the list
    def to_s
      to_a.to_s
    end
  end
end