# encoding: UTF-8
require 'openssl'
require 'securerandom'


salary = "0002500€"

encryptor = OpenSSL::Cipher.new('chacha20')
key = encryptor.key = SecureRandom.bytes(encryptor.key_len)
iv = encryptor.iv = SecureRandom.bytes(encryptor.iv_len)
encryptor.encrypt
encrypted = encryptor.update(salary)

p encrypted

(0..255).each do |i|
  encrypted.setbyte(0, i)
  decryptor = OpenSSL::Cipher.new('chacha20')
  decryptor.key = key
  decryptor.iv = iv
  decryptor.decrypt
  decrypted = decryptor.update(encrypted)

  puts decrypted
end

