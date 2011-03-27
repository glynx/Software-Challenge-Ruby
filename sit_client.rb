require 'proxy_client'
require 'socket'
require 'board'
require 'game_state'
require 'distances'
require 'abstract_logic'
require 'simple_logic'

class SitClient

  attr_accessor :board
  attr_accessor :state
  attr_accessor :logic_class

  def initialize(logic_class = SimpleLogic, options = {})
    @proxy = ProxyClient.new options
    @options = @proxy.options
    @logic_class = logic_class
    @board = []
  end

  def start
    if @connected 
      puts "Can not start, currently connected! Finish first!"
      return false
    end
    if @proxy.connected?
      puts "Proxy is currently connected! Can not start!"
      return false
    end
    Thread.new(@proxy){|proxy| proxy.start}
    
    until @proxy.connected? do 
      # wait
    end
    
    @board = []
    @logic = @logic_class.new(self)

    connect
    play
  end

  def connect
    begin
      puts "Client connecting"
      @socket = TCPSocket.new @options[:host], @options[:proxy_port]
      @connected = true
      puts "Client conected"
    rescue
      puts "Connection failed, retry!"
      retry
    end
  end

  def play
    while @connected
     line = @socket.gets   
     puts line if line
     handle_input line.strip
    end
  end

  def handle_input(input)
     #puts "Parsing: "+input
     if input.start_with? "MOVE_REQUEST"
       @logic.handle_move_request!
     elsif input.start_with? "BEGIN" or input.start_with? "END" 
      # puts "BEGIN or END - "+input
       handle_block input
     elsif @block  
       if @block[0] == "GameState"
          parse_game_state(input)
       elsif @block[0] == "Board"
          parse_board(input)
       end
     else
       puts "Not Handling not implemented for: #{input}"
     end
  end

  def handle_block(msg)
    s = msg.split("|")
    if s[0] == "BEGIN"
      @block = [s[1].strip,[]]
    else
      case s[1].strip
         when "GameState"
	   create_game_state
	 when "Game"
           finished!
	 when "Board"
	   create_board
      end
    end
     
  end

  def send_move!(sheep,target)
    puts "MOVE-sheep:#{sheep.to_i};target:#{target.to_i}"
    @socket.puts("MOVE-sheep:#{sheep.to_i};target:#{target.to_i}")
  end

  def finished!
    @socket.close
    @connected = false
  end
  
  def parse_board(input)
    m = message_to_hash(input)
    @block[1] << m[1]
  end
  
  def message_to_hash(line)
    input = line.split("|")
    type = input[0].strip
    args = input[1].split(";")
    res = {}
    args.each do |arg|
      if arg.include?(":")
        tp = arg.split(":")
        k = tp[0].strip
        v = tp[1].strip
        if v.include? ","
         v = v.split(",")
        end
      else
        v = arg 
      end
      res[k] = v
    end
    return [type,res]
  end

  def create_board 
    @board = Board.new @block[1]
  end

  def create_game_state
    #puts "Creating GameState"
    @state = GameState.new 
    @state.parse_input @block[1], @board
    #puts "Created GameState"
  end

  def parse_game_state(element)
    #puts "Parsing:"+element
    @block[1] << message_to_hash(element)
  end
  
end

