
#Задачи 12, 24, 36, 48, 60

# 12 Дан целочисленный массив. Необходимо переставить в обратном
# порядке элементы массива, расположенные между его минимальным и
# максимальным элементами.


def find_min_index(array)
  array.index(array.min)
end

def find_max_index(array)
  array.index(array.max)
end

def reverse_between_min_max(array)
  max=find_max_index(array)
  min=find_min_index(array)
  min,max=max,min if min>max
  array[0..min].concat(array[min+1..max-1].reverse).concat(array[max..array.length-1])
end

# 24 Дан целочисленный массив. Необходимо найти два наибольших
# элемента.
def find_two_very_max_elements(array)
  max=array.max
  array.delete(max)
  max2=array.max
  [max,max2]
end




