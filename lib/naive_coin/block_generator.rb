class BlockGenerator
  attr_reader :blockchain, :data

  def initialize(blockchain:, data:)
    @blockchain = blockchain
    @data = data
  end

  def execute!
    nonce = 0
    loop do
      attempt_block = Block.build_next_block(blockchain: blockchain, data: @data, nonce: nonce)
      if BlockValidator.new(previous_block: blockchain.last, current_block: attempt_block).valid?
         blockchain.link(block: attempt_block)
         puts attempt_block
         puts "\n\n\n"
         return blockchain
      end
      nonce += 1
    end
  end
end
