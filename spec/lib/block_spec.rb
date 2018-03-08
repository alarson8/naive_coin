require "rspec"
require_relative "../../lib/naive_coin/block"
require_relative "../../lib/naive_coin/genesis_block"

RSpec.describe Block do
  it "initializes the block correctly" do
    block = Block.new(index: 1, previous_hash: "previous_hash", data: "data")

    expect(block.index).to eq(1)
    expect(block.hash).to eq(Digest::SHA256.hexdigest("1previous_hash#{block.timestamp}data"))
    expect(block.previous_hash).to eq("previous_hash")
    expect(block.data).to eq("data")
    expect(block.timestamp).to be_a(Numeric)
  end

  describe ".create_genesis_block" do
    it "creates a block with no previous hash" do
      genesis_block = GenesisBlock.instance

      expect(genesis_block.index).to eq(0)
      expect(genesis_block.previous_hash).to be_nil
      expect(genesis_block.data).to eq("genesis")
      expect(genesis_block.timestamp).to be_a(Numeric)
      expect(genesis_block.hash).to eq(Digest::SHA256.hexdigest("0#{genesis_block.timestamp}genesis"))
    end
  end
end
