RSpec.describe Blockchain do
  describe "#valid?" do
    it "is invalid if the genesis_block is invalid" do
      genesis_block = Factory.build(:genesis_block)
      fake_genesis_block = Factory.build(:block, index: genesis_block.index, previous_hash: genesis_block.previous_hash, data: genesis_block.data)
      blockchain = Factory.build(:blockchain, genesis_block: fake_genesis_block)

      expect(blockchain.valid?).to be(false)
    end

    it "is invalid if any of the remaining blocks are invalid" do
      blockchain = Factory.build(:blockchain)
      invalid_block = Factory.build(:block, previous_hash: "invalid_previous_hash")
      blockchain.link(block: invalid_block)

      expect(blockchain.valid?).to be(false)
    end

    it "is valid if both the genesis_block and remaining blocks are valid" do
      blockchain = Factory.build(:blockchain_with_blocks, blockchain_length: 4)

      expect(blockchain.valid?).to be(true)
    end
  end

  describe "#link" do
    it "adds a block to the chain" do
      blockchain = Factory.build(:blockchain)
      block = Factory.build(:block)

      expect{ blockchain.link(block: block) }.to change{ blockchain.length }.from(1).to(2)
    end
  end

  describe "#[]" do
    it "returns the block from the chain given an index" do
      genesis_block = Factory.build(:genesis_block)
      blockchain = Factory.build(:blockchain, genesis_block: genesis_block)

      expect(blockchain[0]).to eq(genesis_block)
    end
  end

  describe "#last" do
    it "returns the last block from the chain" do
      genesis_block = Factory.build(:genesis_block)
      blockchain = Factory.build(:blockchain, genesis_block: genesis_block)

      expect(blockchain.last).to eq(genesis_block)
    end
  end
end
