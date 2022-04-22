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
      reflexives, strategy_players = @slappers.partition(&:reflexive?)
      return controlled_winner(reflexives, strategy_players)
    when GameTypes::PROBABILISTIC
      reflexives, strategy_players = @slappers.partition(&:reflexive?)
      return probabilstic_winner(reflexives, strategy_players)
    end

    # random_number.rand(0..1).zero? ? reflexives.first : strategy_players.first
    return strategy_players.first if strategy_players.any?

    reflexives.first
  end

  private

  # Assumes there will only be one non-reflexives strategy per controlled game
  def controlled_winner(reflexives, strategy_players)
    _strategy_players_zero_cards, strategy_players = strategy_players.partition(&:empty_hand?)
    return strategy_players.sample if strategy_players.any?

    reflexives.sample
  end

  # I would do this differently if I need to optimize
  def probabilstic_winner(reflexives, strategy_players)
    strategy_players_zero_cards, strategy_players = strategy_players.partition(&:empty_hand?)
    if strategy_players.empty? # strategy_players are not pre-programmed to slap
      # Get one "reflexives winner" from reflexivess and then put the rest in non_winners
      temp_winner = reflexives.sample
      reflexives_winner, reflexives_non_winners = reflexives.partition { |player| player == temp_winner }
      non_slappers_winner = @non_slappers.concat(reflexives_non_winners).concat(strategy_players_zero_cards).sample
      determine_winner(reflexives_winner.first, non_slappers_winner)
    else # strategy_players strategies preprogrammed to slap
      # partition from a random strategy_players winner
      temp_winner = strategy_players.sample
      strategy_players_winner, strategy_players_non_winners = strategy_players.partition { |player| player == temp_winner }
      return strategy_players_winner.first if reflexives.empty?

      reflexives_winner = reflexives.concat(strategy_players_non_winners).concat(strategy_players_zero_cards).sample
      determine_winner(strategy_players_winner.first, reflexives_winner)
    end
  end

  # Returns either param 1 or param 2, param 1 $strategy_win_percentage of the time, param 2 (100 - $strategy_win_percentage) of the time
  def determine_winner(strategy_winner, strategy_loser)
    random_num = ::SecureRandom.random_number(100)
    return strategy_winner if random_num < $strategy_win_percentage

    strategy_loser
  end
end