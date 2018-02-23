require_relative "./calculate_block_hash"

class Block
  attr_reader :index, :previous_hash, :timestamp, :data

  def initialize(index:, previous_hash:, data:)
    @index = index
    @timestamp = Time.now.to_i
    @previous_hash = previous_hash
    @data = data
  end
  
  def hash
    CalculateBlockHash.execute(block: self)
  end

  # def self.create_genesis_block
  #   self.new(index: 0, previous_hash: nil, data: "genesis")
  # end
end
