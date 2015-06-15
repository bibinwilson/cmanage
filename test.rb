#!/usr/bin/env ruby

require 'net/ping'

def up?(host)
    check = Net::Ping::TCP.new(host)
    check.ping
end

chost = '127.0.0.1'
puts up?(chost)