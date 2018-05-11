RSpec.describe Block do
  it "initializes the block correctly" do
    block = Factory.build(:block, index: 1, previous_hash: "previous_hash", data: "data", difficulty: 0)

    expect(block.index).to eq(1)
    expect(block.hash).to eq(Factory.build(:block_hash, block: block))
    expect(block.previous_hash).to eq("previous_hash")
    expect(block.data).to eq("data")
    expect(block.difficulty).to eq(0)
    expect(block.timestamp).to be_a(Numeric)
  end
end
