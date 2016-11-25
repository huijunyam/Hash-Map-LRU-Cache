require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets
    num = key.hash
    self[num] << num
    @count += 1
  end

  def include?(key)
    self[key.hash].include?(key.hash)
  end

  def remove(key)
    self[key.hash].delete(key.hash)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp = @store.flatten
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    # debugger
    temp.each do |num|
      self.insert(num)
    end
  end
end
