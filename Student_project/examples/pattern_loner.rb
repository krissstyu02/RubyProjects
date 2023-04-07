
# Концепция паттерна Одиночка заключается в создании класса, который имеет только
# один экземпляр и гарантирует доступ к этому экземпляру из любой точки программы.
# В этом примере мы создаем класс SingletonExample, который имеет приватный конструктор
# и статический метод instance, который возвращает единственный экземпляр класса.
# Если экземпляр еще не создан, метод instance создаст его.
class SingletonExample
  @@instance = nil

  # Приватный конструктор класса
  private_class_method def initialize
    puts "Создание единственного экземпляра"
  end

  # Метод класса, возвращающий единственный экземпляр
  def self.instance
    @@instance ||= new
  end

  # Метод экземпляра
  def do_something
    puts "Вызов метода экземпляра"
  end
end

# "Создание единственного экземпляра" выводится только один раз,что подтверждает тот факт,
# что класс SingletonExample имеет только один экземпляр.
#
example1 = SingletonExample.instance
example1.do_something

example2 = SingletonExample.instance
example2.do_something
