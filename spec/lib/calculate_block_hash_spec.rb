RSpec.describe CalculateBlockHash do
  describe ".execute" do
    it "calculates a SHA256 hash for a given block" do
      block = Factory.build(:block)
      block_hash = CalculateBlockHash.execute(block: block)

      expect(block_hash).to eq(Digest::SHA256.hexdigest("#{block.index}#{block.previous_hash}#{block.timestamp}#{block.data}"))
    end
  end
end
