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
    count = 0
    self.my_each do |item|
      if block_given?
        count += 1 if block.call(item)
      else
        count += 1
      end
    end
    count
  end

  def my_map(&block)
    map = []
    self.my_each do |item|
      if block_given?
        map << block.call(item)
      else
        return Enumerator.new(self)
      end
    end
    map
  end
end

puts "my_each vs. each"
numbers = [1, 2, 3, 4, 5]
p numbers.my_each
p numbers.each
numbers.my_each { |item| puts item }
numbers.each { |item| puts item }

puts "my_each_with_index vs. each_with_index"
numbers = [1, 2, 3, 4, 5]
p numbers.my_each_with_index
p numbers.each_with_index
numbers.my_each_with_index { |item, idx| puts "#{idx}: #{item}" }
numbers.each_with_index { |item, idx| puts "#{idx}: #{item}" }

puts "my_select vs. select"
numbers = [1, 2, 3, 4, 5]
p numbers.my_select
p numbers.select
puts numbers.my_select { |item| item > 3 }
puts numbers.select { |item| item > 3 }

puts "my_all? vs. all?"
numbers = [1, 2, 3, 4, 5]
p numbers.my_all?
p numbers.all?
puts numbers.my_all? { |item| item > 3 }
puts numbers.all? { |item| item > 3 }

puts "my_any? vs. any?"
numbers = [1, 2, 3, 4, 5]
p numbers.my_any?
p numbers.any?
puts numbers.my_any? { |item| item > 3 }
puts numbers.any? { |item| item > 3 }

puts "my_none? vs. none?"
numbers = []
p numbers.my_none?
p numbers.none?
numbers = [1, 2, 3, 4, 5]
puts numbers.my_none? { |item| item > 3 }
puts numbers.none? { |item| item > 3 }

puts "my_count vs. count"
numbers = [1]
p numbers.my_count
p numbers.count
numbers = [1, 2, 3, 4, 5]
puts numbers.my_count { |item| item > 3 }
puts numbers.count { |item| item > 3 }

puts "my_map vs. map"
numbers = [1]
p numbers.my_map
p numbers.map
numbers = [1, 2, 3, 4, 5]
puts numbers.my_map { |item| item > 3 }
puts numbers.map { |item| item > 3 }
