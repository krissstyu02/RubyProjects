# frozen_string_literal: true

#2
# # Метод 2 Найти количество цифр числа, меньших 3
def count_cifr3(num)
  k=0
  while num>0
    if num%10<3
      k+=1
    end
    num/=10
  end
  return k
end

puts count_cifr3(106754)