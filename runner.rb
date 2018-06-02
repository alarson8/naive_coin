require 'pry'
require_relative 'lib/naive_coin'

blockchain = Blockchain.new(genesis_block: GenesisBlock.instance)


10000.times do |n|

  generator = BlockGenerator.new(blockchain: blockchain, data: 'abc')

  blockchain = generator.execute!
end
