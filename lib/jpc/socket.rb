class JPC::Socket
  def self.run(handler, params = {})
    host = params[:host] || '0.0.0.0'
    port = params[:port] || '8090'

    rpc = JPC::Invoker.new(handler)

    EM::WebSocket.run(host: host, port: port) do |ws|
      ws.onopen do |handshake|
        ip = handshake.headers.fetch('X-Real-IP', '127.0.0.1')

        puts "WS < New connection from #{ip}"
      end

      ws.onclose do
        puts "WS < Connection closed"
      end

      ws.onmessage do |request|
        puts "WS < #{request}"

        response = rpc.invoke(request)
        puts "WS > #{response}"

        ws.send(response)
      end

      ws.onerror do |error|
        backtrace = error.backtrace.join("\n")

        puts "WS: Error #{error}\n#{backtrace}"
      end
    end
  end
end
