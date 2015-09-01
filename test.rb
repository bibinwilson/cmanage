
require 'rest-client'

#resp = RestClient::Request.execute(method: :get, timeout: 5, url: 'http://10.23.23.34')
resp = RestClient::Request.execute(:method => :get, :url => 'http://10.23.23.34', :timeout => 15 )

puts resp