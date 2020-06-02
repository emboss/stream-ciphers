require_relative 'rng'
require_relative 'string_refinements'

using StringRefinements

class StreamCipher

  attr_reader :key, :rng

  def initialize(key)
    @rng = RNG.new(key)
  end

  def encrypt(data)
    pad = rng.bytes(data.size)
    data.xor(pad)
  end
  alias_method :decrypt, :encrypt

end

key = "\x00" * 16
data = "Attack at dawn"
puts "Data length: #{data.size}"

encrypter = StreamCipher.new(key)
encrypted = encrypter.encrypt(data)

p encrypted

decrypter = StreamCipher.new(key)
decrypted = decrypter.decrypt(encrypted)

puts decrypted
puts data == decrypted
