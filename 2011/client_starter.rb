#!/usr/bin/ruby
require 'sit_client'

def info
  puts "This is the SchaefchenImTockenen Ruby Client, providing a simple way to develop a client in Ruby \n Git-Repository: http://github.com/glynx/Software-Challenge-Ruby/ \n Provided under GPL License \n By André Domnick (andre@paniccrew.de)"
end

def display_usage
  puts "USAGE:"
  puts " -h <host> / --host <host> \n   	The host you want to connect to"
  puts "\n -p <port> / --port <port> \n	The port of the server you want to connect (default: 13050)"
  puts "\n -r <reservation-id> / --reservation <reservation-id> \n	The reservation id of the room to join"
  puts "\n -pp <proxy-port> / --proxy_port <proxy-port> \n	The port the proxy is opened (default:14000)" 
  puts "\n -l <logfile> / --logfile <logfile> \n	Prints proxy logs into given logfile (default: proxy.log) "
  puts "\n -lg <Logic Class> / --logic_class <Logic Class> \n		Sets the logic of the client (default: SimpleLogic) "
  puts "\n -v / --verbose \n 	Log the received XML and the written data" 
  puts "\n --help \n	Displays this message"
end

def argv_to_hash
  args_hash = {}
  current_key = nil
  ARGV.each do |a|
    a_s = a.downcase.strip
    if a_s.start_with? "-"
       current_key = translate_arg(a_s.delete("-"))
       args_hash[current_key] = ""
    else
       if not current_key or not args_hash[current_key].empty?
         puts "ERROR: Parsing arguments failed! #{a_s} is invalid at this position!"
	 puts "\n\n"
	 display_usage
	 exit
       else
         args_hash[current_key] = a_s
       end
    end
  end
  args_hash
end

def translate_arg(arg)
  case arg
    when "i","info"
      :info
    when "p", "port"
      :port
    when "r", "reservation"
      :reservation
    when "h","host"
      :host
    when "help"
      :help
    when "l", "logfile"
      :logfile
    when "pp", "proxy_port"
      :proxy_port
    when "v", "verbose"
      :verbose
    when "lg", "logic_class"
      :logic_class
    else 
       puts "Unknown argument #{arg}!"
       puts "\n\n"
       display_usage
       exit
    end
end

args_hash = argv_to_hash

if args_hash[:info] 
  info
  exit
end

if args_hash[:help] 
  display_usage
  exit
end

args_hash[:exit_on_socket_close] = :true

if args_hash[:logic_class]
  begin
    logic_class = eval args_hash[:logic_class] 
  rescue 
    puts "Error, logic_class: #{args_hash[:logic_class]} could not be found, check if it is required in sit_client.rb"
    exit
  end
end

p = SitClient.new((logic_class || SimpleLogic),args_hash)
p.start



