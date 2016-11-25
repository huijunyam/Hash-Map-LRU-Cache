require 'prime'

class Fixnum
  # Fixnum#hash already implemented for you
end

class Array

  def hash
    return 0 if self.empty?
    prime_list = Prime.first(self.length)
    map.with_index do |el, i|
      el * prime_list[i]
    end.inject(:+)
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
    keys_arr = self.keys.map(&:to_s).sort.map(&:ord)
    values_arr = self.values.map(&:to_s).sort.map(&:ord)
    (keys_arr + values_arr).hash
  end
end
