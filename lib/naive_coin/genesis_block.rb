require "singleton"

class GenesisBlock
  include Singleton

  EPOCH_TIME = 1519427401

  attr_reader :index, :timestamp, :previous_hash, :data, :difficulty, :nonce

  def initialize
    @index = 0
    @timestamp = EPOCH_TIME
    @previous_hash = nil
    @data = "genesis"
    @nonce = 0
    @difficulty = 0
  end

  def hash
    CalculateBlockHash.execute(block: self)
  end
end
