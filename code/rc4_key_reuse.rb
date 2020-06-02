require 'openssl'

require_relative 'string_refinements'

using StringRefinements

data1 = "Attack at dawn"
data2 = " " * data1.size

data3 = "AAAxxxBBByyy"
data4 = "CCCxxxDDDabc"

def encrypt(data)
  key = "\x00" * 16
  cipher = OpenSSL::Cipher.new("rc4")
  cipher.key = key
  cipher.encrypt
  cipher.update(data)
end

encrypted1 = encrypt(data1)
encrypted2 = encrypt(data2)
encrypted3 = encrypt(data3)
encrypted4 = encrypt(data4)

p encrypted1.xor(encrypted2) # => "aTTACK\x00AT\x00DAWN"
p encrypted3.xor(encrypted4) # => "\x02\x02\x02\x00\x00\x00\x06\x06\x06\x18\e\x1A"
