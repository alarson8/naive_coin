RSpec.describe BlockchainDifficulty do
  describe "#get" do
    context "when the chain is only the genesis block" do
      it "returns the genesis block's difficulty" do
        genesis_block = GenesisBlock.instance
        blockchain = Factory.build(:blockchain, genesis_block: genesis_block)

        expect(BlockchainDifficulty.new(blockchain: blockchain).get).to eq(genesis_block.difficulty)
      end
    end

    context "when the chain requires an adjustment evaluation" do
      it "increases the difficulty by one if the time taken was too fast" do
        blockchain = Factory.build(:blockchain_with_blocks, blockchain_length: 10)
        original_difficulty = blockchain.last.difficulty

        block = Factory.build(:block, index: 10, previous_hash: blockchain.last.hash, difficulty: blockchain.last.difficulty)
        blockchain.link(block: block)

        expect(BlockchainDifficulty.new(blockchain: blockchain).get).to eq(original_difficulty + 1)
      end

      it "decreases the difficulty by one if the time taken was too slow" do
        blockchain = Factory.build(:blockchain_with_blocks, blockchain_length: 10)
        original_difficulty = blockchain.last.difficulty

        Timecop.freeze(Time.now + 201.seconds) do
          block = Factory.build(:block, index: 10, previous_hash: blockchain.last.hash, difficulty: blockchain.last.difficulty)
          blockchain.link(block: block)
        end

        expect(BlockchainDifficulty.new(blockchain: blockchain).get).to eq(original_difficulty - 1)
      end

      it "returns the last block's difficulty if the time taken was just right" do
        blockchain = Factory.build(:blockchain_with_blocks, blockchain_length: 10)
        original_difficulty = blockchain.last.difficulty

        Timecop.freeze(Time.now + 100.seconds) do
          block = Factory.build(:block, index: 10, previous_hash: blockchain.last.hash, difficulty: blockchain.last.difficulty)
          blockchain.link(block: block)
        end

        expect(BlockchainDifficulty.new(blockchain: blockchain).get).to eq(original_difficulty)
      end
    end

    context "when the chain does not require an adjustment" do
      it "returns the last block's difficulty" do
        blockchain = Factory.build(:blockchain_with_blocks, blockchain_length: 4)

        expect(BlockchainDifficulty.new(blockchain: blockchain).get).to eq(blockchain.last.difficulty)
      end
    end
  end
end
