# lsof -i tcp:2345 this shows if tcp2345 is runnign
# if one is running to get rid of it =- kill -9 {pid} (from the previous lsof)

# request response cycle

require 'socket'

class Server
  def initialize
    @server = TCPServer.new('localhost', 2345)
  end

  def run
    loop do
      # Wait for a connection
      socket = @server.accept
      puts "Incoming Request"

      # Read the HTTP request. We know it's finished when we see a line with nothing but \r\n
      http_request = ""
      while (line = socket.gets) && (line != "\r\n")
        http_request += line
      end
      puts "#{http_request} - WAS ENTERED"
      # puts http_request
      socket.close
    end
  end
end

class Client
  def initialize(address)
    # connect using eventmachine
    # conn = EventMachine::WebSocketClient.connect("ws://echo.websocket.org/")
  end

  def broadcast(message)
    # new block
  end
end
