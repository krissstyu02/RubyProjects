# frozen_string_literal: true

# Паттерн Наблюдатель (Observer) - это поведенческий паттерн проектирования,
# который позволяет объектам следить и реагировать на изменения состояния других объектов.

# Наблюдаемый объект
class Observable
  attr_reader :observers

  def initialize
    @observers = []
  end

  def add_observer(observer)
    @observers << observer
  end

  def remove_observer(observer)
    @observers.delete(observer)
  end

  def notify_observers
    @observers.each { |observer| observer.update(self) }
  end

  def do_something
    puts "Наблюдаемый объект: сделал что-то!"
    notify_observers
  end
end

# Наблюдатель
class Observer
  def update(observable)
    puts "Наблюдатель: получил оповещение от #{observable.class.name}"
  end
end

# Пример использования
observable = Observable.new
observer = Observer.new

observable.add_observer(observer)

observable.do_something
# Вывод:
# Наблюдаемый объект: сделал что-то!
# Наблюдатель: получил оповещение от Observable

observable.remove_observer(observer)

observable.do_something
# Вывод:
# Наблюдаемый объект: сделал что-то!

