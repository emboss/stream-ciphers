require 'securerandom'

require_relative 'rng'
require_relative 'string_refinements'

using StringRefinements

class StreamCipher

  attr_reader :key, :iv, :rng

  def initialize(key:, iv:)
    randomized_key = key.xor(iv)
    @rng = RNG.new(randomized_key)
  end

  def encrypt(data)
    pad = rng.bytes(data.size)
    data.xor(pad)
  end
  alias_method :decrypt, :encrypt

end

key = "\x00" * 16
iv = SecureRandom.bytes(16)
data = "Attack at dawn"
puts "Data length: #{data.size}"

encrypter = StreamCipher.new(key: key, iv: iv)
encrypted = encrypter.encrypt(data)

p encrypted # => Nichtdeterministisch

decrypter = StreamCipher.new(key: key, iv: iv)
decrypted = decrypter.decrypt(encrypted)

puts decrypted # => Attack at dawn
puts data == decrypted # => true
