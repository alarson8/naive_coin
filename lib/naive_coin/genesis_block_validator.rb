require_relative "./genesis_block"

class GenesisBlockValidator
  attr_reader :genesis_block

  def initialize(genesis_block:)
    @genesis_block = genesis_block
  end

  def valid?
    GenesisBlock.instance.hash == genesis_block.hash
  end
end
