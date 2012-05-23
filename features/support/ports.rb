require 'socket'

def connect_to_port(host, port)
  begin
    Timeout::timeout(1) do
      begin
        socket = TCPSocket.new(host, port)
        socket.close
        return true
      rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH, Errno::ETIMEDOUT
        return false
      end
    end
  rescue Timeout::Error
    return false
  end
end