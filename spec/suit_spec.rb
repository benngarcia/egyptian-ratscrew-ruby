require 'suit'

RSpec.describe Suit do
  it "properly compares suits" do
    ace = Suit.new :ace
    king = Suit.new :king
    king2 = Suit.new :king

    expect(ace <=> king).to eq 1
    expect(king <=> king2).to eq 0
    expect(king > ace).to eq false
  end
end