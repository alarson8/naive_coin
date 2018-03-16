require 'socket'

class Server
  def initialize
    @server = TCPServer.new('localhost', 2345)
  end

  def run
    loop do
      # Wait for a connection
      socket = @server.accept
      STDERR.puts "Incoming Request"

      # Read the HTTP request. We know it's finished when we see a line with nothing but \r\n
      http_request = ""
      while (line = socket.gets) && (line != "\r\n")
        http_request += line
      end
      STDERR.puts http_request
      socket.close
    end
  end
end


class Client
  def initialize(address)
    # connect using eventmachine
  end

  def broadcast(message)
    # new block
  end
end
