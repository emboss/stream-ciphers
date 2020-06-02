require 'openssl'
require 'securerandom'

data = "Attack at dawn"
puts "Data length: #{data.size}" # => 14

encryptor = OpenSSL::Cipher.new('chacha20')
key = encryptor.key = "\x00" * encryptor.key_len
iv = encryptor.iv = SecureRandom.bytes(encryptor.iv_len)
encryptor.encrypt
encrypted = encryptor.update(data)

p encrypted # => nichtdeterministisch
puts encrypted.size # => 14

decryptor = OpenSSL::Cipher.new('chacha20')
decryptor.key = key
decryptor.iv = iv
decryptor.decrypt
decrypted = decryptor.update(encrypted)

puts decrypted
puts data == decrypted # => true
puts "ChaCha20 key length: #{encryptor.key_len}" # => 32
puts "ChaCha20 IV length: #{encryptor.iv_len}" # => 16

