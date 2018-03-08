require "rspec"
require_relative "../../lib/naive_coin/blockchain"
require_relative "../../lib/naive_coin/block"
require_relative "../../lib/naive_coin/genesis_block"


RSpec.describe Blockchain do
  describe "#valid?" do
    it "is invalid if the genesis_block is invalid" do
      fake_genesis_block = Block.new(index: 0, previous_hash: nil, data: "genesis")
      blockchain = Blockchain.new(genesis_block: fake_genesis_block)

      expect(blockchain.valid?).to be(false)
    end

    it "is invalid if any of the remaining blocks are invalid" do
      genesis_block = GenesisBlock.instance
      blockchain = Blockchain.new(genesis_block: genesis_block)
      invalid_block = Block.new(index: 1, previous_hash: "previous_hash", data: "data")

      blockchain.link(block: invalid_block)

      expect(blockchain.valid?).to be(false)
    end

    it "is valid if both the genesis_block and remaining blocks are valid" do
      genesis_block = GenesisBlock.instance
      blockchain = Blockchain.new(genesis_block: genesis_block)
      block = Block.new(index: 1, previous_hash: genesis_block.hash, data: "data")

      blockchain.link(block: block)

      expect(blockchain.valid?).to be(true)
    end
  end

  describe "#link" do
    it "adds a block to the chain" do
      genesis_block = GenesisBlock.instance
      blockchain = Blockchain.new(genesis_block: genesis_block)
      block = Block.new(index: 1, previous_hash: genesis_block.hash, data: "data")

      expect{ blockchain.link(block: block) }.to change{ blockchain.length }.from(1).to(2)
    end
  end
end
