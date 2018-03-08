require "rspec"
require_relative "../../lib/naive_coin/block"
require_relative "../../lib/naive_coin/block_validator"
require_relative "../../lib/naive_coin/genesis_block"

RSpec.describe BlockValidator do
  describe "#valid?" do
    it "returns true for a valid block" do
      genesis_block = GenesisBlock.instance
      current_block = Block.new(index: genesis_block.index + 1,
                             previous_hash: genesis_block.hash,
                             data: "next_block")

      validator = BlockValidator.new(previous_block: genesis_block,
                                     current_block: current_block)
      expect(validator.valid?).to eq(true)
    end
  end
end
