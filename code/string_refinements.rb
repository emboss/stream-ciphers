module StringRefinements
  refine String do
    def xor(other)
      raise "Length mismatch" unless bytesize == other.bytesize
      each_byte.zip(other.each_byte).map do |(a, b)|
        a ^ b
      end.map(&:chr).join("")
    end

    def secure_equals?(other)
      return false unless bytesize == other.bytesize
      (each_byte.zip(other.each_byte).inject(0) { |memo, (a, b)|
        memo | (a ^ b)
      }) == 0
    end
  end
end

