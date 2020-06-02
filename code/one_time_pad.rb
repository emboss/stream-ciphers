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

data = "Attack at dawn"
pad = SecureRandom.bytes(data.size)

encrypted = OneTimePad.encrypt(data, pad)

# Zufällig, aber immer gleich lang wie die ursprüngliche Nachricht
p encrypted

decrypted = OneTimePad.decrypt(encrypted, pad)

puts decrypted
puts data == decrypted
