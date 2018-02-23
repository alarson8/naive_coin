require_relative "./calculate_block_hash"

class BlockValidator
  def initialize(previous_block:, current_block:)
    @previous_block = previous_block
    @current_block = current_block
  end

  def valid?
    valid_structure? && valid_index? && valid_previous_hash? && valid_hash?    
  end

  def invalid?
    !valid?
  end
  
  private

  attr_reader :previous_block, :current_block

  def valid_structure?
    (current_block&.index.is_a?(Integer) &&
     current_block&.hash.is_a?(String) &&
     current_block&.previous_hash.is_a?(String) &&
     current_block&.timestamp.is_a?(Integer) &&
     current_block&.data.is_a?(String))
  end

  def valid_index?
    previous_block.index + 1 == current_block.index
  end

  def valid_previous_hash?
    previous_block.hash == current_block.previous_hash
  end

  def valid_hash?
    CalculateBlockHash.execute(block: current_block) == current_block.hash
  end
end
