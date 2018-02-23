require "digest"

class CalculateBlockHash
  def self.execute(block:)
    Digest::SHA256.hexdigest("#{block.index}#{block.previous_hash}#{block.timestamp}#{block.data}")
  end
end
