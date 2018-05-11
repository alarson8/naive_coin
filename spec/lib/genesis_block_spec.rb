RSpec.describe GenesisBlock do
  it "initializes the genesis_block correctly" do
    genesis_block = GenesisBlock.instance

    expect(genesis_block.index).to eq(0)
    expect(genesis_block.previous_hash).to be_nil
    expect(genesis_block.data).to eq("genesis")
    expect(genesis_block.timestamp).to eq(GenesisBlock::EPOCH_TIME)
    expect(genesis_block.hash).to eq(Factory.build(:block_hash, block: genesis_block))
  end
end
