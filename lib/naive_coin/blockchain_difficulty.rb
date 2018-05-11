class BlockchainDifficulty

  BLOCK_GENERATION_INTERVAL = 10
  DIFFICULTY_ADJUSTMENT_INTERVAL = 10

  def initialize(blockchain:)
    @blockchain = blockchain
  end

  def get
    latest_block = @blockchain.last
    if latest_block.index % DIFFICULTY_ADJUSTMENT_INTERVAL == 0 && latest_block.index != 0
      adjusted_difficulty(latest_block)
    else
      latest_block.difficulty
    end
  end

  private

  attr_reader :blockchain

  def adjusted_difficulty(latest_block)
    previous_adjustment_block = blockchain[blockchain.length - DIFFICULTY_ADJUSTMENT_INTERVAL]
    expected_time = BLOCK_GENERATION_INTERVAL * DIFFICULTY_ADJUSTMENT_INTERVAL
    time_taken = latest_block.timestamp - previous_adjustment_block.timestamp
    if time_taken < expected_time / 2
      previous_adjustment_block.difficulty + 1
    elsif time_taken > expected_time * 2
      previous_adjustment_block.difficulty - 1
    else
      previous_adjustment_block.difficulty
    end
  end
end
