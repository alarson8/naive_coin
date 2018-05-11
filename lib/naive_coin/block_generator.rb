require_relative 'block'
class BlockGenerator
  DIFFICULTY = 7
  attr_reader :index, :previous_hash, :data

  def initialize(index:, previous_hash:, data:)
    @index = index
    @previous_hash = previous_hash
    @data = data
  end

  def execute!
    nonce = 0
    loop do
      test_block = Block.new(index: index, previous_hash: previous_hash, data: "#{data}#{nonce}")
      if test_block.to_binary.match(/^0{#{DIFFICULTY}}/)
        puts nonce
        return test_block
      end
      puts "#{nonce}: #{test_block.to_binary.length}"
      nonce += 1
    end
  end
end
