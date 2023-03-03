# frozen_string_literal: true
#1 Написать методы, которые находят минимальный, элементы, номер первого положительного элемента. Каждая
# операция в отдельном методе. Решить задачу с помощью циклов(for и while).
# 2 Написать программу, которая принимает как аргумент два значения. Первое значение говорит, какой из методов задачи
# 1 выполнить, второй говорит о том, откуда читать список аргументом должен быть написан адрес файла. Далее
# необходимо прочитать массив и выполнить метод.


#возвращает минимальный элемент массива
def min_el(list)
  if list.empty?
    return nil
  end

  min=list[0]
  for el in list do
    min=el if el<min
  end
  min
end

#возвращает максимальный элемент массива
def max_el(list)
  if list.empty?
    return nil
  end

  max=list[0]
  for el in list do
    max=el if el>max
  end
  max
end

#индекс первого положительного элемента
def first_index_positive(list)
  i=0
  while i<list.size && list[i]<0
    i+=1
  end
  return nil if list.empty? || list[i]<0
  i
end

list=[-1,2,7,3]
puts max_el(list)
puts min_el(list)
puts(first_index_positive(list))


if ARGV.count<2
  puts 'Недостаточно аргументов! Выберите метод и файл для чтения!'
  return
end

num_method = ARGV[0].to_i
file_name=ARGV[1]
return unless num_method > 0 && num_method < 3
list=File.open(file_name){|file| file.readlines.map(&:to_i)}

methods = [method(:min_el), method(:max_el), method(:first_index_positive)]
methods_name = ["минимальный элемент", "максимальный элемент", "индекс первого положительного элемента"]
puts "Результат работы метода(#{methods_name[num_method]}): #{methods[num_method].call(list)}"