module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    for item in self do
      yield item
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    for current_index in 0...self.length
      yield self[current_index], current_index
    end
  end

  def my_select(&block)
    return to_enum(:my_select) unless block_given?

    selected = self.is_a?(Hash) ? {} : []

    if self.is_a? Hash
      self.my_each { |key, value| selected[key] = value if block.call(key, value) }
    else
      self.my_each { |item| selected << item if block.call(item) }
    end
    selected
  end

  def my_all?(&block)
    self.my_each do |item|
      if block_given?
        return false unless block.call(item)
      else
        return false unless item
      end
    end
    true
  end

  def my_any?(&block)
    self.my_each do |item|
      if block_given?
        return true if block.call(item)
      else
        return true if item
      end
    end
    false
  end

  def my_none?(&block)
    self.my_each do |item|
      if block_given?
        return false if block.call(item)
      else
        return false if item
      end
    end
    true
  end

  def my_count(&block)
    return self.length unless block_given?

    count = 0
    self.my_each { |item| count += 1 if block.call(item) }
    count
  end

  def my_map(&block)
    return to_enum(:my_map) unless block_given?

    map = []
    self.my_each { |item| map << block.call(item) }
    map
  end

  def my_inject(starting_value = nil, &block)
    return self.first if self.length == 1
    raise LocalJumpError, "no block given" unless block_given?

    if starting_value
      result = starting_value
      starting_index = 0
    else
      result = self.first
      starting_index = 1
    end

    self[starting_index..].my_each { |item| result = block.call(result, item) }
    result
  end
end

def multiply_els(arr)
  arr.my_inject { |result, item| result * item }
end

# puts "my_each vs. each"
# numbers = [1, 2, 3, 4, 5]
# p numbers.my_each
# p numbers.each
# numbers.my_each { |item| puts item }
# numbers.each { |item| puts item }
# hash = { a: 1, b: 2 }
# hash.my_each { |key, value| puts "#{key}: #{value}" }
# hash.each { |key, value| puts "#{key}: #{value}" }

# puts "my_each_with_index vs. each_with_index"
# numbers = [1, 2, 3, 4, 5]
# p numbers.my_each_with_index
# p numbers.each_with_index
# numbers.my_each_with_index { |item, idx| puts "#{idx}: #{item}" }
# numbers.each_with_index { |item, idx| puts "#{idx}: #{item}" }

# puts "my_select vs. select"
# numbers = [1, 2, 3, 4, 5]
# p numbers.my_select
# p numbers.select
# puts numbers.my_select { |item| item > 3 }
# puts numbers.select { |item| item > 3 }
# hash = { a: 1, b: 2 }
# puts hash.my_select { |key, value| value > 1 }
# puts hash.select { |key, value| value > 1 }

puts "my_all? vs. all?"
numbers = [1, 2, 3, 4, 5]
p numbers.my_all?
p numbers.all?
puts numbers.my_all? { |item| item > 3 }
puts numbers.all? { |item| item > 3 }
hash = { a: 1, b: 2 }
puts hash.my_all? { |key, value| value > 1 }
puts hash.all? { |key, value| value > 1 }

# puts "my_any? vs. any?"
# numbers = [1, 2, 3, 4, 5]
# p numbers.my_any?
# p numbers.any?
# puts numbers.my_any? { |item| item > 3 }
# puts numbers.any? { |item| item > 3 }

# puts "my_none? vs. none?"
# numbers = []
# p numbers.my_none?
# p numbers.none?
# numbers = [1, 2, 3, 4, 5]
# puts numbers.my_none? { |item| item > 3 }
# puts numbers.none? { |item| item > 3 }

# puts "my_count vs. count"
# numbers = [1]
# p numbers.my_count
# p numbers.count
# numbers = [1, 2, 3, 4, 5]
# puts numbers.my_count { |item| item > 3 }
# puts numbers.count { |item| item > 3 }

# puts "my_map vs. map"
# numbers = [1]
# p numbers.my_map
# p numbers.map
# numbers = [1, 2, 3, 4, 5]
# puts numbers.my_map { |item| item > 3 }
# puts numbers.map { |item| item > 3 }

# puts "my_inject vs. inject"
# numbers = [1]
# p numbers.my_inject
# p numbers.inject
# numbers = [2, 4, 5]
# puts multiply_els(numbers)
# puts numbers.inject { |result, item| result * item }
