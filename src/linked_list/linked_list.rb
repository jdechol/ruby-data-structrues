class LinkedList
  attr_accessor :head, :tail, :length

  def initialize(data = nil)
    @head = Node.new(data)
    @tail = head
    @length = data ? 1 : 0
  end

  def add_last(data)
    if tail.data.nil?
      tail.data = data
    else
      current = tail
      @tail = Node.new(data)
      current.next = tail
      tail.previous = current
    end
    @length += 1
  end

  def add_first(data)
    if head.data.nil?
      head.data = data
    else
      current = head
      @head = Node.new(data)
      @head.next = current
      current.previous = head
    end
    @length += 1
  end

  def add_at(index, data)
    raise NotImplementedError
  end

  def get_first
    head&.data
  end

  def get_last
    raise NotImplementedError
  end

  def clear
    @head = Node.new
    @tail = head
  end

  def find_element(&block)
    node, = find(&block)
    node.data
  end

  def index_of(&block)
    _, index = find(&block)
    index
  rescue StandardError
    -1
  end

  def contains?(&block)
    index_of(&block) != -1
  end

  def remove(&block)
    node, = find(&block)

    case node
    when head
      @head = head.next
    when tail
      @tail.previous.next = nil
      @tail = tail.previous
    else
      node.previous.next = node.next
      node.next.previous = node.previous
    end
    @length -= 1
  end

  private

  def find
    node = head
    index = 0
    until yield(node.data) || node.next.nil?
      node = node.next
      index += 1
    end

    raise StandardError, "could not find element!" unless yield(node.data)

    [node, index]
  end
end

class Node
  attr_accessor :next, :previous, :data

  def initialize(data = nil)
    @data = data
  end
end
