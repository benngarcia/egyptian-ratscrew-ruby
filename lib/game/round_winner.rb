class RoundWinner
  def initialize(slappers, game_type, non_slappers = [])
    @slappers = slappers
    @game_type = game_type
    @random = Random.new(Time.now.to_i)
    @non_slappers = non_slappers
  end

  def winner
    return nil if @slappers.length.zero?
    return @slappers.first if @slappers.length == 1

    # Implement logic for player type Enums and Game type here
    case @game_type
    when GameTypes::CONTROLLED
      reflexive, other = @slappers.partition(&:reflexive?)
      return controlled_winner(reflexive, other)
    when GameTypes::PROBABILISTIC
      reflexive, other = @slappers.partition(&:reflexive?)
      return probabilstic_winner(reflexive, other)
    end

    # random_number.rand(0..1).zero? ? reflexive.first : other.first
    return other.first if other.any?

    reflexive.first
  end

  private

  # Assumes there will only be one non-reflexive strategy per controlled game
  def controlled_winner(reflexive, other)
    return other.first if other.any?

    reflexive.first
  end

  # I would do this differently if I need to optimize
  def probabilstic_winner(reflexive, other)
    if other.empty? # Others are not pre-programmed to slap
      reflexive_winner = reflexive.sample # Get one "Reflexive winner" from reflexives
      non_slappers_winner = @non_slappers.sample # Get one "Non Reflexive" "winner"
      seventy_five_twenty_five_odds(reflexive_winner, non_slappers_winner)
    else # Other strategies preprogrammed to slap
      other_winner = other.sample # 75% chance winning for pre-emptive slapping
      reflexive_winner = reflexive.sample # reflexives gotta chance tho!\
      seventy_five_twenty_five_odds(other_winner, reflexive_winner)
    end
  end

  # Returns either param 1 or param 2, param 1 75% of the time, param 2 25% of the time
  def seventy_five_twenty_five_odds(seventy_five, twenty_five)
    # @random.rand(3) # This is what I would do if I didn't trust the ruby sample method so much lol
    # and then just check if value is last value, return twenty_five, else return seventy_five
    # too lazy to make sure this works tho
    selection_array = []
    9.times do
      selection_array.append seventy_five
    end
    selection_array.append twenty_five
    selection_array.sample
  end
end