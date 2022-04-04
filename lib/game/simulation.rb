# This is dumb, lol
class Simulation
  # Default 100k iterations
  def initialize(sim_type:, strategies:, player_count:, iteration_count: 100_000)
    @sim_type = sim_type
    @iteration_count = iteration_count
    @strategies = strategies
    @num_players = player_count
  end

  def to_s
    "Run #{@iteration_count} #{@sim_type} games with #{@num_players} players, #{strategies_stringified_helper} and the rest reflexive"
  end

  def all_faces_2_player
    @strategies = [Strategies::QUALITATIVE::ALL_FACES]
    @num_players = 2
    self
  end

  def all_faces_4_player
    @strategies = [Strategies::QUALITATIVE::ALL_FACES]
    @num_players = 4
    self
  end

  def jack_through_king_2_player
    @strategies = [Strategies::QUALITATIVE::JACK_THROUGH_KING]
    @num_players = 2
    self
  end

  def jack_through_king_4_player
    @strategies = [Strategies::QUALITATIVE::JACK_THROUGH_KING]
    @num_players = 4
    self
  end

  def two_card_slap_2_player
    @strategies = [Strategies::QUANTITATIVE::TWOCARD]
    @num_players = 2
    self
  end

  def two_card_slap_4_player
    @strategies = [Strategies::QUANTITATIVE::TWOCARD]
    @num_players = 4
    self
  end

  def three_card_slap_2_player
    @strategies = [Strategies::QUANTITATIVE::THREECARD]
    @num_players = 2
    self
  end

  def three_card_slap_4_player
    @strategies = [Strategies::QUANTITATIVE::THREECARD]
    @num_players = 4
    self
  end

  def four_card_slap_2_player
    @strategies = [Strategies::QUANTITATIVE::FOURCARD]
    @num_players = 2
    self
  end

  def four_card_slap_4_player
    @strategies = [Strategies::QUANTITATIVE::FOURCARD]
    @num_players = 4
    self
  end

  def five_card_slap_2_player
    @strategies = [Strategies::QUANTITATIVE::FIVECARD]
    @num_players = 2
    self
  end

  def five_card_slap_4_player
    @strategies = [Strategies::QUANTITATIVE::FIVECARD]
    @num_players = 4
    self
  end

  def six_card_slap_2_player
    @strategies = [Strategies::QUANTITATIVE::SIXCARD]
    @num_players = 2
    self
  end

  def six_card_slap_4_player
    @strategies = [Strategies::QUANTITATIVE::SIXCARD]
    @num_players = 4
    self
  end

  def run!
    @count = @strategies.to_h { |strategy| [strategy, 0] }.merge({ reflexive: 0 })
    @iteration_count.times do
      players = generate_players!
      winner = Game.new(players, @sim_type).run_game!
      @count[winner] += 1
    end
    @count
  end

  private

  def generate_players!
    # Add players
    players = gen_special_players_from_strategies!

    # Fill rest of game with Reflexives
    players.append(Player.new(Strategies::REFLEXIVE)) until players.size == @num_players
    players
  end

  def gen_special_players_from_strategies!
    @strategies.map { |strategy| Player.new(strategy) }
  end

  def strategies_stringified_helper
    @strategies.map(&:to_s).join ', '
  end
end