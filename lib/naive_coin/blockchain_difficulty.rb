class BlockchainDifficulty
  BLOCK_GENERATION_INTERVAL = 10
  DIFFICULTY_ADJUSTMENT_INTERVAL = 10

  def initialize(blockchain:)
    @blockchain = blockchain
  end

  def get
    last_block = @blockchain.last
    if last_block.index % DIFFICULTY_ADJUSTMENT_INTERVAL == 0 && last_block.index != 0
      adjusted_difficulty(last_block)
    else
      last_block.difficulty
    end
  end

  private

  attr_reader :blockchain

  def adjusted_difficulty(last_block)
    previous_adjustment_block = blockchain[blockchain.length - DIFFICULTY_ADJUSTMENT_INTERVAL]
    expected_time = BLOCK_GENERATION_INTERVAL * DIFFICULTY_ADJUSTMENT_INTERVAL
    time_taken = last_block.timestamp - previous_adjustment_block.timestamp
    if time_taken < expected_time / 2
      previous_adjustment_block.difficulty + 1
    elsif time_taken > expected_time * 2
      previous_adjustment_block.difficulty - 1
    else
      previous_adjustment_block.difficulty
    end
  end
end
