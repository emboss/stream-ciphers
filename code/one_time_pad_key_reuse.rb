require 'securerandom'

require_relative 'string_refinements'

using StringRefinements

module OneTimePad

  def encrypt(data, pad)
    data.xor(pad)
  end
  alias_method :decrypt, :encrypt
  module_function :encrypt, :decrypt

end

data1 = "Attack at dawn"
data2 = " " * data1.size

data3 = "AAAxxxBBByyy"
data4 = "CCCxxxDDDabc"

pad = SecureRandom.bytes(data1.size)

encrypted1 = OneTimePad.encrypt(data1, pad)
encrypted2 = OneTimePad.encrypt(data2, pad)

p encrypted1 # Zufällige Bytes
p encrypted2 # Zufällige Bytes

xor_encrypted = encrypted1.xor(encrypted2)
p xor_encrypted # "aTTACK\x00AT\x00DAWN"

pad = SecureRandom.bytes(data3.size)

encrypted1 = OneTimePad.encrypt(data3, pad)
encrypted2 = OneTimePad.encrypt(data4, pad)

xor_encrypted = encrypted1.xor(encrypted2)
p xor_encrypted # "\x02\x02\x02\x00\x00\x00\x06\x06\x06\x18\e\x1A"

