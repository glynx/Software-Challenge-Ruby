require 'socket'
require 'nokogiri'
require 'logger'

class ProxyClient
  DEFAULTS = {:host => "127.0.0.1", :port => 13050, :proxy_port => 14000, :logfile => "proxy.log"}  
  attr_accessor :socket,:client_socket,:room_i, :room_id
  attr_reader :options, :logger

  def initialize(args = {})
    @options = DEFAULTS.merge(args)
    file = File.open(@options[:logfile], File::WRONLY | File::APPEND | File::CREAT)
    @logger = Logger.new(file)
  end
  
  def log(message, type = "info")
    @logger.send(type,message)
  end

  def verbose?
    !!@options[:verbose]
  end

  def start
   log "Trying to connect to GameServer: #{@options[:host]}:#{@options[:port]}"
   begin   
    @socket = TCPSocket.new @options[:host],@options[:port]
     log "Connected to GameServer"
    @connected = true
   rescue 
     sleep 0.25
     retry
   end
   
   @reader = Thread.new(self) { |proxy_client| ProxyServer.new proxy_client }

   log "Initialized ProxyServer, joining game"
   
   sleep 0.5

   object_stream do
     join # join a game
     listen # listen for incoming commands 
   end

   @socket.close
   exit if @options[:exit_on_socket_close]   
  end

  def connected?
    !!@connected 
  end

  def listen
    until @client_socket
      # wait
      sleep 0.2
    end

    while connected?
      line = @client_socket.gets
      handle_message line
    end
  end

  def finished!
    @connected = false
  end

  def handle_message(line)
    return false if line.empty?
    log "Received from Client: #{line}"
    a = line.split("-")
    identifier = a[0].strip.upcase
    payload = a[1].split(";")
    args = {}
    payload.each{|arg|
       b = arg.split(":")
       args[b[0].strip.downcase] = b[1].strip.downcase
    }
    case identifier
      when "MOVE"
        room do
	  write '<data class="sit:move" id="1337" sheep="'+args['sheep']+'" target="'+args['target']+'"/>'
	end
      else
        log "unknown message #{line}", 'warn'
    end
  end

  def write(data)
    @socket.write_nonblock(%{#{data}\n})   
    log data, 'debug' if verbose?
  end

  def object_stream(&block)
    write "<object-stream>"
    instance_eval &block
    write "</object-stream>"
  end

  def room(&block)
   write '<room roomId="'+self.room_id+'">'
   instance_eval &block
   write "</room>"
  end

  def join(args = {:gameType => "swc_2011_schaefchen_im_trockenen"})
    if @options[:reservation]
      write %{<joinPrepared reservationCode="#{args[:reservation]}/>}
    else
      write %{<join gameType="#{args[:gameType]}"/>}
    end
  end

  
end


class ProxyServer
  
  def initialize(proxy_client)
    @proxy_client = proxy_client
    @options = @proxy_client.options
    start
  end

  def log(message, type = "info")
    @proxy_client.log message, type
  end

  def start
    @incoming_socket = @proxy_client.socket
    begin 
      log "Starting ProxyServer at #{@options[:proxy_port]}"
      @server = TCPServer.open(@options[:proxy_port])
    rescue
      log "Could not start server: #{$!}", 'warn' if @proxy_client.verbose?
      sleep 0.5
      retry
    end
    log "Proxy-Server started"
    @client = @server.accept
    @proxy_client.client_socket = @client   
    log "A Client connected to the proxy"
    read
  end

  def read
    write "// Welcome this is the Software-Challenge 2011 Proxy // "
    write "BEGIN|Game"
    input_buffer = ""
    while @proxy_client.connected?
      finished = false
      data = ""
      begin
      until finished 
        while line = @incoming_socket.read_nonblock(1024) and not finished
         input_buffer << line  
	 room_index = input_buffer.index "</room>"
	 if room_index
           data = input_buffer.slice(0..room_index + 6)
	   data.gsub!("<protocol>","") if data.include? "<protocol>"
	   joined_token = data.scan(/<joined roomId="\S*"\/>/).first
	   data.gsub!(joined_token,"") if joined_token
           input_buffer = input_buffer.slice(room_index + 7 .. input_buffer.length - 1)
	   finished = true;
	 end 
	end
      end
      rescue
       sleep 0.05
       retry
      end
      #puts data
      document = Nokogiri::XML(data)
      parse_message document
    end
  end

  def parse_message(document)
    begin
    data = document.xpath('room/data').first
    data_class = data.attribute('class').to_s
    @proxy_client.room_id = document.xpath('room').first.attribute('roomId').to_s  if not @proxy_client.room_id
    case data_class
      when "memento"
        parse_state data.xpath("state")
      when "sit:welcome"
        parse_welcome data.xpath("node")
      when "result"
        parse_result data
	finished!
      when "paused"
        write parse_paused data.children.first
      when "sc.framework.plugins.protocol.MoveRequest"
        write "MOVE_REQUEST"
      when "error"
        write "ERROR|"+data.attribute('message').to_s
	finished!
      else
        log "Unknown: #{data_class}", "warn"
    end
    rescue 
      puts $!
    end
   end

  def parse_element(element)
   write element.name.upcase + "|" + element.attributes.collect{|a|
     a.join(":")
   }.join(";")
  end

  def parse_state(gameState)
    send_block :GameState do
      write "CURRENT|turn:#{gameState.attribute('turn')};player:#{gameState.attribute('currentPlayer')}" if gameState.attribute('currentPlayer') and gameState.attribute('turn')
      gameState.children.each do |child|
        case child.name
          when "flowers", "player", "sheep", "die"
            parse_element child
	  end
      end
    end
  end

  def send_block(type = "Game",&block)
   write "BEGIN|"+type.to_s
   instance_eval &block
   write "END|"+type.to_s
  end
  
  def parse_welcome(nodes)
    send_block :Board do 
      nodes.each do |node| 
         write "NODE|ID:#{node.attribute('index')};type:#{node.attribute('type')};neighbours:#{node.xpath('neighbour').collect{|c| c.text.strip}.join(",")}" 
      end
    end
  end

  def parse_paused(nextPlayer)
    write "PAUSED|#{parse_element nextPlayer}"
  end

  def parse_result(data)
    send_block :Result do
      for child in data
        case child.name 
          when "definition"
            parse_result_defintion child
          when "score"
  	    write "SCORE|cause:#{child.attribute('cause')};parts:#{child.children.collect{|part| part.text}.join(",")}"
	  when "winner"
  	   write parse_element child
        end
      end
    end
  end

  def write(data)
    @client.write_nonblock(%{#{data}\n})   
    log data, "debug" if @proxy_client.verbose?
  end

  def finished!
    write "END|Game"
    write "CLOSING SOCKET!"
    @server.close
    @proxy_client.finished!
  end
end
