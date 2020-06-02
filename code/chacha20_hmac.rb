# encoding: UTF-8
require 'openssl'
require 'securerandom'

require_relative 'string_refinements'

using StringRefinements

salary = "0002500€"

encryptor = OpenSSL::Cipher.new('chacha20')
key = encryptor.random_key
iv = encryptor.random_iv
encryptor.encrypt
mac_key = SecureRandom.bytes(32)
mac = OpenSSL::HMAC.new(mac_key, OpenSSL::Digest::SHA256.new)

# encrypt-
encrypted = encryptor.update(salary)
# then-mac
mac.update(encrypted)
tag = mac.digest

# Modifikation
encrypted.setbyte(0, encrypted.getbyte(0) + 1)
p encrypted

decryptor = OpenSSL::Cipher.new('chacha20')
decryptor.key = key
decryptor.iv = iv
decryptor.decrypt
verifier = OpenSSL::HMAC.new(mac_key, OpenSSL::Digest::SHA256.new)

# encrypt-then-mac, daher umgekehrte Reihenfolge
verifier.update(encrypted)
recomputed_tag = verifier.digest
# Entschlüsselter String ist immer ASCII-8BIT aka Encoding::BINARY
# Muss daher explizit als UTF-8 interpretiert werden
decrypted = decryptor.update(encrypted).force_encoding(Encoding::UTF_8)

puts decrypted

puts salary == decrypted

unless tag.secure_equals?(recomputed_tag)
  puts "Ciphertext wurde modifiziert"
else
  puts "Ciphertext im Originalzustand"
end

