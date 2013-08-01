require "rubygems"
require "openssl"
require 'socket'
require "json"

cert = File.read("apns.pem")
ctx = OpenSSL::SSL::SSLContext.new
ctx.key = OpenSSL::PKey::RSA.new(cert, '1111') #set passphrase here, if any
ctx.cert = OpenSSL::X509::Certificate.new(cert)

sock = TCPSocket.new('gateway.sandbox.push.apple.com', 2195) #development gateway
ssl = OpenSSL::SSL::SSLSocket.new(sock, ctx)
ssl.connect

payload = {"aps" => {"alert" => "Hey! You've received new private message!", "badge" => 1}, "type" => "GroupInvite", "forum_id" => "3"}
json = payload.to_json()
token = "35817936D06100BCD811998EB2E8AB469605C17B5CC4CA53FA2B15DEF045CADD"
token =  [token.delete(' ')].pack('H*') #something like 2c0cad 01d1465 346786a9 3a07613f2 b03f0b94b6 8dde3993 d9017224 ad068d36
apnsMessage = "\0\0 #{token}\0#{json.length.chr}#{json}"

p ssl.write(apnsMessage)

ssl.close
sock.close