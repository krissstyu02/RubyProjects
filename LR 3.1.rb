# frozen_string_literal: true

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