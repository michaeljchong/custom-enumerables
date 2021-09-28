module Enumerable
  def my_each
    if block_given?
      for item in self
        yield item
      end
      self
    else
      Enumerator.new(self)
    end
  end

  def my_each_with_index
    if block_given?
      current_index = 0
      while current_index < self.length
        yield self[current_index], current_index
        current_index += 1
      end
      self
    else
      Enumerator.new(self)
    end
  end

  def my_select(&block)
    if block_given?
      selected = []
      self.my_each do |item|
        selected << item if block.call(item)
      end
      selected
    else
      Enumerator.new(self)
    end
  end

  def my_all?(&block)
    if block_given?
      self.my_each do |item|
        return false unless block.call(item)
      end
      true
    else
      Enumerator.new(self)
    end
  end
end

# puts "my_each vs. each"
# numbers = [1, 2, 3, 4, 5]
# numbers.my_each { |item| puts item }
# numbers.each { |item| puts item }

# puts "my_each_with_index vs. each_with_index"
# numbers = [1, 2, 3, 4, 5]
# numbers.my_each_with_index  { |item, idx| puts "#{idx}: #{item}" }
# numbers.each_with_index  { |item, idx| puts "#{idx}: #{item}" }

# puts "my_select vs. select"
# numbers = [1, 2, 3, 4, 5]
# puts numbers.my_select  { |item| item > 3 }
# puts numbers.select  { |item| item > 3 }

puts "my_all? vs. all?"
numbers = [1, 2, 3, 4, 5]
puts numbers.my_all?  { |item| item > 3 }
puts numbers.all?  { |item| item > 3 }

