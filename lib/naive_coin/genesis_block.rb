require "singleton"
require_relative "./calculate_block_hash"

class GenesisBlock
  include Singleton

  EPOCH_TIME = 1519427401

  attr_reader :index, :timestamp, :previous_hash, :data, :difficulty

  def initialize
    @index = 0
    @timestamp = EPOCH_TIME
    @previous_hash = nil
    @data = "genesis"
    @difficulty = 0
  end

  def hash
    CalculateBlockHash.execute(block: self)
  end
end
