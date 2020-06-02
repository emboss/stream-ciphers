require 'openssl'

data = "Attack at dawn"
puts "Data length: #{data.size}" # => 14

encryptor = OpenSSL::Cipher.new("rc4")
key = encryptor.key = "\x00" * encryptor.key_len
encryptor.encrypt
encrypted = encryptor.update(data)
last = encryptor.final

p encrypted # => "\x9Fl\xFD \xC0\\}[\xFE&z\x06 \x00"
puts encrypted.size # => 14

decryptor = OpenSSL::Cipher.new("rc4")
decryptor.key = key
decryptor.decrypt
decrypted = decryptor.update(encrypted)

puts decrypted # => Attack at dawn
puts data == decrypted # => true

# "decrypt" = "encrypt"
encryptor = OpenSSL::Cipher.new("rc4")
encryptor.key = key
encryptor.decrypt
encrypted = encryptor.update(data)

p encrypted # => "\x9Fl\xFD \xC0\\}[\xFE&z\x06 \x00"

decryptor = OpenSSL::Cipher.new("rc4")
decryptor.key = key
decryptor.encrypt
decrypted = decryptor.update(encrypted)

puts decrypted # => Attack at dawn
puts data == decrypted # => true

puts "RC4 key length: #{encryptor.key_len}" # => 16
puts "RC4 iv length: #{encryptor.iv_len}" # => 0
