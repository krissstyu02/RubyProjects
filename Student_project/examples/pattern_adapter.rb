# Паттерн адаптер (Adapter pattern) позволяет обернуть объекты разных классов
# в единый интерфейс, чтобы они могли взаимодействовать между собой.
# Это полезно, когда вы хотите использовать объекты, которые не имеют совместимого интерфейса,
#  но должны работать вместе.

# мы создали адаптеры SquareAdapter и CircleAdapter,
#  которые оборачивают объекты Square и Circle соответственно, и предоставляют метод draw,
#  оторый вызывает соответствующий метод рисования для каждого объекта.

  # Адаптер для квадрата
class SquareAdapter
  def initialize(square)
    @square = square
  end

  def draw
    @square.draw_square
  end
end

# Адаптер для круга
class CircleAdapter
  def initialize(circle)
    @circle = circle
  end

  def draw
    @circle.draw_circle
  end
end

# Классы Square и Circle
class Square
  def draw_square
    puts "Рисуем квадрат"
  end
end

class Circle
  def draw_circle
    puts "Рисуем круг"
  end
end

# передаем каждому из них соответствующий адаптер
# Класс для рисования
class Drawing
  def initialize(shape)
    @shape = shape
  end

  def draw_shape
    @shape.draw
  end
end

# Использование
square = Square.new
circle = Circle.new

square_adapter = SquareAdapter.new(square)
circle_adapter = CircleAdapter.new(circle)

drawing1 = Drawing.new(square_adapter)
drawing1.draw_shape

drawing2 = Drawing.new(circle_adapter)
drawing2.draw_shape
# frozen_string_literal: true

