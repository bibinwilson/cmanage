require 'socket'      # Sockets are in standard library

hostname = 'LP-3C970EE1AB15'
port = 3000

s = TCPSocket.open(hostname, port)

while line = s.gets   # Read lines from the socket
  puts line.chop      # And print with platform line terminator
end
s.close               # Close the socket when done