module Factory
  def self.build(obj, options = {})
    case obj
    when :block
      default_options = { index: 1, previous_hash: "previous_hash", data: "data", difficulty: 0 }
      Block.new(default_options.merge(options))
    when :genesis_block
      GenesisBlock.instance
    when :block_hash
      default_options = { block: self.build(:block) }
      block = default_options.merge(options)[:block]
      Digest::SHA256.hexdigest("#{block.index}#{block.previous_hash}#{block.timestamp}#{block.data}")
    when :blockchain
      default_options = { genesis_block: self.build(:genesis_block) }
      Blockchain.new(default_options.merge(options))
    when :blockchain_with_blocks
      blockchain_length = options[:blockchain_length] - 1
      blockchain = self.build(:blockchain)
      blockchain_length.times do |n|
        last_block = blockchain.last
        new_block = self.build(:block, { index: last_block.index + 1, previous_hash: last_block.hash, difficulty: BlockchainDifficulty.new(blockchain: blockchain).get })
        blockchain.link(block: new_block)
      end
      blockchain
    end
  end
end
