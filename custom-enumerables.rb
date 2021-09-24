module Enumerable
  def my_each
    if block_given?
      for item in self
        yield item
      end
    end
  end

  def my_each_with_index
    if block_given?
      for item in self
        yield item
      end
    end
  end
end

puts "my_each vs. each"
numbers = [1, 2, 3, 4, 5]
numbers.my_each  { |item| puts item }
numbers.each  { |item| puts item }

# puts "my_each_with_index vs. each_with_index"
# numbers = [1, 2, 3, 4, 5]
# numbers.my_each_with_index  { |item, idx| puts "#{idx}: #{item}" }
# numbers.each_with_index  { |item, idx| puts "#{idx}: #{item}" }
