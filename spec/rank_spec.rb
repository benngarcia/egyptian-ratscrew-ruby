require 'rank'

RSpec.describe Rank do
  it "properly compares ranks" do
    ace = Rank.new :ace
    king = Rank.new :king
    king2 = Rank.new :king

    expect(ace <=> king).to eq 1
    expect(king <=> king2).to eq 0
    expect(king > ace).to eq false
  end
end