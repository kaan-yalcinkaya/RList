# RList
RList is a Ruby implementation of the doubly linked list

# Test
´´´
require_relative 'list'

list = List.new
list.copy!(%w[wElCoMe To ThE rLiSt])
list.copy!(%w[lets fix this])

list.collect! { |str| str.downcase }
list.each { |str| print str, ' ' }
#output: welcome to the rlist lets fix this
list.copy!(%w[okay! we fixed that])

list2 = List.new
list2 << :hello
list2 << 'this is another list'
list2 << %w[but this time we hold objects of a different data type]
list2.copy!([1,:one, 2, 'two', 3, {three: 3}])
list2.each { |e| print e, ' ' }

def isa(name)
    lambda {|e| e.is_a?name}
end

strings = list2.select(&isa(String))
arrays = list2.select(&isa(Array))
numbers = list2.select(&isa(Integer))
hashes = list2.select(&isa(Hash))

puts strings, arrays, numbers, hashes
´´´
