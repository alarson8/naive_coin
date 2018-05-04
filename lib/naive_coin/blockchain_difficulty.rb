class BlockchainDifficulty

  BLOCK_GENERATION_INTERVAL = 10
  DIFFICULTY_ADJUSTMENT_INTERVAL = 10

  def initialize(chain:)
    @chain = chain
  end

  def execute!
    latest_block = @chain[-1]
    if latest_block.index % DIFFICULTY_ADJUSTMENT_INTERVAL == 0 && latest_block.index = 0
      adjusted_difficulty(latest_block)
    else
      latest_block.difficulty
    end
  end

  private

  def adjusted_difficulty(latest_block)
    previous_adjustment_block
  end
end
