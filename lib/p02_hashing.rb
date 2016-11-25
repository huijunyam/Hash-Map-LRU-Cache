require 'prime'

class Fixnum
  # Fixnum#hash already implemented for you
end

class Array

  def hash
    return 0 if self.empty?
    prime_list = Prime.first(self.length)
    result = map.with_index do |el, i|
      el * prime_list[i]
    end.inject(:+)

    if result.is_a?(Array)
      result = result.hash - 1
    end
    result
  end
end

class String
  def hash
    return 0 if length.zero?
    self.chars.map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    return 0 if keys.empty?
    pairs = []
    self.each_pair do |k, v|
      pairs << [k, v]
    end.sort { |x, y| x[0] <=> y[0] }.flatten.map(&:to_s).map(&:ord).hash
  end
end
