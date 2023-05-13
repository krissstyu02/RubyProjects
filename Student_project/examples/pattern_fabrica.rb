# frozen_string_literal: true

# Паттерн "Фабрика" (Factory) относится к классу порождающих паттернов проектирования.
#   Он используется для создания объектов без необходимости явного указания их класса.
#     Вместо этого используется фабричный метод, который определяет
# интерфейс для создания объектов, но оставляет сам процесс создания подклассам.

# Класс Shape - это абстрактный класс, который определяет интерфейс для всех конкретных классов фигур
class Shape
  def draw
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# Класс Circle - это конкретный класс, который наследуется от абстрактного класса Shape и реализует метод draw()
class Circle < Shape
  def draw
    puts "Drawing Circle"
  end
end

# Класс Square - это конкретный класс, который наследуется от абстрактного класса Shape и реализует метод draw()
class Square < Shape
  def draw
    puts "Drawing Square"
  end
end

# Фабрика ShapeFactory создает конкретные объекты фигур на основе переданного параметра shape_type
class ShapeFactory
  def self.create(shape_type)
    case shape_type
    when 'circle'
      Circle.new
    when 'square'
      Square.new
    else
      raise ArgumentError, "Invalid shape type: #{shape_type}"
    end
  end
end

# Создание конкретных объектов фигур с помощью фабричного метода
circle = ShapeFactory.create('circle')
square = ShapeFactory.create('square')

# Вызов методов draw() на созданных объектах
circle.draw   # => "Drawing Circle"
square.draw   # => "Drawing Square"

