require "singleton"
require_relative "./calculate_block_hash"

class GenesisBlock
  include Singleton

  EPOCH_TIME = 1519427401

  attr_reader :index, :timestamp, :previous_hash, :data

  def initialize
    @index = 0
    @timestamp = EPOCH_TIME
    @previous_hash = nil
    @data = "genesis"
  end

  def hash
    CalculateBlockHash.execute(block: self)
  end
end
