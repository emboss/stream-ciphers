# encoding: UTF-8
require 'openssl'

salary = "0002500€"

encryptor = OpenSSL::Cipher.new('chacha20-poly1305')
key = encryptor.random_key
iv = encryptor.random_iv
encryptor.encrypt
encrypted = encryptor.update(salary) << encryptor.final
tag = encryptor.auth_tag

p encrypted
puts encrypted.size
puts "ChaCha20/Poly1305 key length: #{encryptor.key_len}" # => 32
puts "ChaCha20/Poly1305 IV length: #{encryptor.iv_len}" # => 12

# Modifikation
encrypted.setbyte(0, encrypted.getbyte(0) + 1)

decryptor = OpenSSL::Cipher.new('chacha20-poly1305')
decryptor.key = key
decryptor.iv = iv
decryptor.auth_tag = tag
decryptor.decrypt

begin
  decrypted = decryptor.update(encrypted) << decryptor.final
  puts decrypted.encoding
  # Entschlüsselter String ist immer ASCII-8BIT aka Encoding::BINARY
  # Muss daher explizit als UTF-8 interpretiert werden
  decrypted.force_encoding(Encoding::UTF_8)

  puts decrypted
  puts salary == decrypted # => true
  puts "Ciphertext im Originalzustand"
rescue OpenSSL::Cipher::CipherError => e
  puts "Ciphertext wurde modifiziert"
end

