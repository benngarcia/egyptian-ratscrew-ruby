require 'securerandom'
class RoundWinner
  def initialize(slappers, game_type, non_slappers = [])
    @slappers = slappers
    @game_type = game_type
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
      # Get one "Reflexive winner" from reflexives and then put the rest in non_winners
      reflexive_winner, reflexive_non_winners = reflexive.partition { |player| player == reflexive.sample } 
      non_slappers_winner = @non_slappers.concat(reflexive_non_winners).sample # Get one winner from all other players
      determine_winner(reflexive_winner.first, non_slappers_winner)
    else # Other strategies preprogrammed to slap
       # partition from a random other winner
      other_winner, other_non_winners = other.partition { |player| player == other.sample }
      return other_winner.first if reflexive.empty?

      reflexive_winner = reflexive.concat(other_non_winners).sample # reflexives gotta chance tho!\
      determine_winner(other_winner.first, reflexive_winner)
    end
  end

  # Returns either param 1 or param 2, param 1 $strategy_win_percentage of the time, param 2 (100 - $strategy_win_percentage) of the time
  def determine_winner(strategy_winner, strategy_loser)
    random_num = ::SecureRandom.random_number(100)
    return strategy_winner if random_num < $strategy_win_percentage

    strategy_loser
  end
end