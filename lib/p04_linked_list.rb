class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.

  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    return nil if search(key).nil?
    search(key).val
  end

  def include?(key)
    !search(key).nil?
  end

  def append(key, val)
    new_link = Link.new(key, val)
    new_link.prev = @tail.prev
    new_link.next = @tail
    @tail.prev = new_link
    new_link.prev.next = new_link
  end

  def update(key, val)
    return if search(key).nil?
    search(key).val = val
  end

  def remove(key)
    link = search(key)
    link.next.prev = link.prev
    link.prev.next = link.next
    link.next, link.prev = link.prev, link.next
  end

  def search(key)
    search = @head.next
    until search == @tail
      return search if search.key == key
      search = search.next
    end
    nil
  end

  def each(&prc)
    node = @head.next
    until node == @tail
      prc.call(node) if block_given?
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
