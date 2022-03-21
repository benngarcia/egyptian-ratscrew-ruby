class RoundWinner
  def initialize(slappers, game_type)
    @slappers = slappers
    @game_type = game_type
  end

  def winner
    return nil if @slappers.length.zero?
    random_number = Random.new(Time.now.to_i)
    return @slappers.first if @slappers.length == 1

    # Implement logic for player type Enums and Game type here
    case @game_type
    when GameTypes::CONTROLLED
      # reflexive, other = @slappers.partition(&:reflexive?)
    when GameTypes::PROBABILISTIC
      reflexive, other = @slappers.partition(&:reflexive?)
    end

    random_number.rand(0..1).zero? ? reflexive.first : other.first
    # return other.first if other.any?

    # reflexive.first
  end
end