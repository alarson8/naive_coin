class Block
  attr_reader :index, :previous_hash, :timestamp, :data, :difficulty, :nonce

  def self.build_next_block(blockchain:, data:, nonce:)
    self.new(index: blockchain.last.index + 1,
             previous_hash: blockchain.last.hash,
             data: data,
             difficulty: BlockchainDifficulty.new(blockchain: blockchain).get,
             nonce: nonce)
  end

  def initialize(index:, previous_hash:, data:, difficulty:, nonce:)
    @index = index
    @timestamp = Time.now.to_i
    @previous_hash = previous_hash
    @data = data
    @difficulty = difficulty
    @nonce = nonce
  end

  def hash
    CalculateBlockHash.execute(block: self)
  end

  def to_binary
    hash.hex.to_s(2).rjust(hash.size * 4, '0')
  end

  def to_s
    "####################\nIndex: #{index}\nBinary: #{to_binary[0..difficulty + 3]}\nNonce: #{nonce}\nDifficulty: #{difficulty}\n####################"
  end
end
