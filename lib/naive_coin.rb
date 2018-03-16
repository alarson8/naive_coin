require_relative "./naive_coin/block"
require_relative "./naive_coin/block_validator"
require_relative "./naive_coin/blockchain"
require_relative "./naive_coin/calculate_block_hash"
require_relative "./naive_coin/genesis_block"
require_relative "server"

Server.new.run
