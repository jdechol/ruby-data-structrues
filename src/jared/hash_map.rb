module Jared
  class HashMap
    attr :map, :size

    def initialize(size = 16)
      @size = size
      @map = Array.new(size)
    end

    def put(key, value)
      index = index_of(key)

      if map[index].nil?
        map[index] = LinkedList.new(OpenStruct.new(key: key, value: value))
      elsif list_contains(map[index], key)
        map[index].get { |data| data.key == key }.value = value
      else
        map[index].add_first(OpenStruct.new(key: key, value: value))
      end
    end

    def get(key)
      index = index_of(key)
      if list_contains(map[index], key)
        map[index].get { |data| data.key == key }.value
      else
        raise StandardError "The element #{key} could not be found"
      end
    end

    private

    def list_contains(list, key)
      list.contains? { |data| data.key == key }
    end

    def index_of(key)
      key.hash % size
    end
  end
end
