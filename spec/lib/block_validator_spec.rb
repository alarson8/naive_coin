RSpec.describe BlockValidator do
  describe "#valid?" do
    it "returns true for a valid block" do
      genesis_block = Factory.build(:genesis_block)
      current_block = Factory.build(:block, index: genesis_block.index + 1, previous_hash: genesis_block.hash)

      validator = BlockValidator.new(previous_block: genesis_block, current_block: current_block)

      expect(validator.valid?).to eq(true)
    end

    it "returns false for an invalid block structure" do
      genesis_block = Factory.build(:genesis_block)
      current_block = Factory.build(:block, index: 'incorrect_data_type', previous_hash: genesis_block.hash)

      validator = BlockValidator.new(previous_block: genesis_block, current_block: current_block)

      expect(validator.valid?).to eq(false)
    end

    it "returns false for an index that did not increment by one" do
      genesis_block = Factory.build(:genesis_block)
      current_block = Factory.build(:block, index: genesis_block.index + 2, previous_hash: genesis_block.hash)

      validator = BlockValidator.new(previous_block: genesis_block, current_block: current_block)

      expect(validator.valid?).to eq(false)
    end

    it "returns false for an invalid previous_hash" do
      genesis_block = Factory.build(:genesis_block)
      current_block = Factory.build(:block, index: genesis_block.index, previous_hash: 'invalid_previous_hash')

      validator = BlockValidator.new(previous_block: genesis_block, current_block: current_block)

      expect(validator.valid?).to eq(false)
    end

    it "returns false for a timestamp more then 1 minute in the future" do
      previous_block = Factory.build(:block)
      Timecop.freeze(Time.now + 61.seconds)
      current_block = Factory.build(:block, index: previous_block.index + 1, previous_hash: previous_block.hash)
      Timecop.return

      validator = BlockValidator.new(previous_block: previous_block, current_block: current_block)

      expect(validator.valid?).to eq(false)
    end

    it "returns false for a timestamp more then 1 minute before the prevous_block's timestamp" do
      previous_block = Factory.build(:block)
      Timecop.freeze(Time.at(previous_block.timestamp) - 1.minute)
      current_block = Factory.build(:block, index: previous_block.index + 1, previous_hash: previous_block.hash)
      Timecop.return

      validator = BlockValidator.new(previous_block: previous_block, current_block: current_block)

      expect(validator.valid?).to eq(false)
    end
  end
end
