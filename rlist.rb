class List
    private
    class Node
        attr_accessor :prev_n, :next_n, :data
        def initialize(data)
            @data, @prev_n, @next_n = data, nil, nil
        end
    end
    public
    attr_reader :length
    def initialize
        @head, @tail, @length = nil, nil, 0
    end
    def <<(data)
        if @head.nil?
            @head = @tail = Node.new data
        else
            @tail.next_n = Node.new data
            @tail.next_n.prev_n = @tail
            @tail = @tail.next_n
        end
        @length += 1
    end
    def push_front(data)
        if @head.nil?
            @head = @tail = Node.new data
        else
            @head.prev_n = Node.new(data)
            @head.prev_n.next_n = @head
            @head = @head.prev_n
        end
        @length += 1
    end
    def each
        iter = @head
        while iter
            yield(iter.data)
            iter = iter.next_n
        end
    end
    def copy(object)
        return nil if object.nil?
        new_list = List.new
        if object.is_a?Array || object.is_a?(List)
            object.each { |e| new_list << e}
        elsif object.is_a?Hash
            object.each_value { |v| new_list << v}
        else
            return nil
        end
        new_list
    end
    def copy!(object)
        return nil if object.nil?
        if object.is_a?Array || object.is_a?(List)
            object.each { |e| self << e}
        elsif object.is_a?Hash
            object.each_value { |v| self << v}
        else
            nil
        end
    end
    def to_a
        arr = []
        @head.nil? ? arr : self.each {|i| arr << i}
    end
    def each_with_index
        i = 0
        self.each { |e| yield(e, i); i += 1}
    end
    def [](index)
        self.each_with_index { |e, i| return e if index == i}
    end
    def []=(index, data)
        if index == length
            self << data
        elsif index < length
            i = 0
            iter = @head
            while iter
                if i == index
                    iter.data = data
                    break
                end
                i += 1
                iter = iter.next_n
            end
        end
    end
    def collect
        iter = @head
        new_list = List.new
        while iter
            new_list << yield(iter.data)
            iter = iter.next_n
        end
        new_list
    end
    def collect!
        iter = @head
        while iter
            iter.data = yield(iter.data)
            iter = iter.next_n
        end
    end
    def select
        iter = @head
        arr = []
        while iter
            arr << iter.data if yield(iter.data)
            iter = iter.next_n
        end
        arr
    end
    def pop_back
        return if @head.nil?
        if @tail.prev_n.nil?
            @head, @tail, @length = nil, nil, 0
        else
            @tail = @tail.prev_n
            @tail.next_n = nil
            @length -= 1
        end
    end
    def pop_front
        return if @head.nil?
        if @head.next_n.nil?
            @head, @tail, @length = nil, nil, 0
        else
            @head = @head.next_n
            @head.prev_n = nil
            @length -= 1
        end
    end
end
