require_relative "./calculate_block_hash"

class Block
  attr_reader :index, :previous_hash, :timestamp, :data, :difficulty

  def initialize(index:, previous_hash:, data:, difficulty:)
    @index = index
    @timestamp = Time.now.to_i
    @previous_hash = previous_hash
    @data = data
    @difficulty = difficulty
  end

  def hash
    CalculateBlockHash.execute(block: self)
  end

  def to_binary
    hash.unpack("B*").first
  end
end
