require "rubygems"
require "openssl"
require 'socket'
require "json"

cert = File.read("production.pem")
ctx = OpenSSL::SSL::SSLContext.new
ctx.key = OpenSSL::PKey::RSA.new(cert, '1111') #set passphrase here, if any
ctx.cert = OpenSSL::X509::Certificate.new(cert)

sock = TCPSocket.new('gateway.push.apple.com', 2195) #development gateway
ssl = OpenSSL::SSL::SSLSocket.new(sock, ctx)
ssl.connect

payload = {"aps" => {"alert" => "Hey! You've received new private message!", "badge" => 1}, "type" => "Location", "place_id" => "444", "place_type" => "hjl" }
json = payload.to_json()
token = "D22B5A6D28C2075A38D90F88383BCF6ADB0164A893DE119642AD52752D952E14"
token =  [token.delete(' ')].pack('H*') #something like 2c0cad 01d1465 346786a9 3a07613f2 b03f0b94b6 8dde3993 d9017224 ad068d36
apnsMessage = "\0\0 #{token}\0#{json.length.chr}#{json}"

p ssl.write(apnsMessage)

ssl.close
sock.close