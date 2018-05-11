RSpec.describe BlockValidator do
  describe "#valid?" do
    it "returns true for a valid block" do
      genesis_block = Factory.build(:genesis_block)
      current_block = Factory.build(:block, index: genesis_block.index + 1, previous_hash: genesis_block.hash)
      validator = BlockValidator.new(previous_block: genesis_block, current_block: current_block)

      expect(validator.valid?).to eq(true)
    end
  end
end
