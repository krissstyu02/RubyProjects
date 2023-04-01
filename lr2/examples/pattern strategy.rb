# frozen_string_literal: true
class Calculator
  attr_accessor :strategy

  def initialize(strategy)
    @strategy = strategy
  end

  def calculate(a, b)
    @strategy.calculate(a, b)
  end
end

class AdditionStrategy
  def calculate(a, b)
    a + b
  end
end

class SubtractionStrategy
  def calculate(a, b)
    a - b
  end
end

# Использование
addition = AdditionStrategy.new
calculator = Calculator.new(addition)
puts calculator.calculate(3, 4) # => 7

subtraction = SubtractionStrategy.new
calculator.strategy = subtraction
puts calculator.calculate(10, 5) # => 5

