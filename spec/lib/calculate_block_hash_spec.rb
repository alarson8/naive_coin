require "rspec"
require_relative "../../lib/naive_coin/block"
require_relative "../../lib/naive_coin/calculate_block_hash"

RSpec.describe CalculateBlockHash do
  describe ".execute" do
    it "calculates a SHA256 hash for a given block" do
      block = Block.new(index: 1, previous_hash: "previous_hash", data: "data")
      hash = CalculateBlockHash.execute(block: block)

      expect(hash)
        .to eq(Digest::SHA256.hexdigest("#{block.index}#{block.previous_hash}#{block.timestamp}#{block.data}"))
    end
  end
end
