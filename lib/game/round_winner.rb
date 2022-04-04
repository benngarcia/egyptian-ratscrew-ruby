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
      determine_winner(reflexive_winner, non_slappers_winner)
    else # Other strategies preprogrammed to slap
      other_winner = other.sample # 75% chance winning for pre-emptive slapping
      return other_winner if reflexive.empty?

      reflexive_winner = reflexive.sample # reflexives gotta chance tho!\
      determine_winner(other_winner, reflexive_winner)
    end
  end

  # Returns either param 1 or param 2, param 1 $strategy_win_percentage of the time, param 2 (100 - $strategy_win_percentage) of the time
  def determine_winner(strategy_winner, strategy_loser)
    random_num = @random.rand(100)
    return strategy_winner if random_num < $strategy_win_percentage

    strategy_loser
  end
end