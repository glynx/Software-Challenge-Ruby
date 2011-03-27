require 'simple_client'
require 'proxy_client'
Thread.new{
  SimpleClient.new
}

a = ProxyClient.new
a.start
 


