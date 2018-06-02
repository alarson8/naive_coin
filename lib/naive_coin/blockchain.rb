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

  def length
    chain.length
  end

  def [](index)
   chain[index]
  end

  def last
    chain.last
  end

  private

  attr_reader :chain

  def valid_genesis_block?
    GenesisBlockValidator.new(genesis_block: chain.first).valid?
  end

  def valid_blocks?
    linkings = chain.each_cons(2).to_a
    linkings.all? do |linking|
      BlockValidator.new(previous_block: linking.first, current_block: linking.last).valid?
    end
  end
end
