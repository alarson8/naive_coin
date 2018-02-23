require_relative "./block_validator"
require_relative "./genesis_block_validator"

class Blockchain
  def initialize(genesis_block:)
    @chain = [genesis_block]
  end

  def link(block:)
    @chain << block
  end

  def valid?
    valid_genesis_block? && valid_blocks?
  end

  private

  attr_reader :chain

  def valid_genesis_block?
    GenesisBlockValidator.new(genesis_block: chain.first).valid?
  end

  def valid_blocks?
    chain[1..-1].each do |block|
      previous_block = chain[block.index - 1]
      if BlockValidator.new(previous_block: previous_block, current_block: block).invalid?
        return false
      end
    end

    return true
  end
end
