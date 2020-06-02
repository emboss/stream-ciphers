require 'openssl'

class RNG
  def initialize(seed)
    @digest = OpenSSL::Digest::SHA256.new
    @state = @digest.digest(seed)
  end

  def bytes(n)
    result = String.new
    while result.size < n
      result += @state
      @state = @digest.digest(@state)
    end
    result[0...n]
  end
end


