# frozen_string_literal: true

#Метод 1 Найти сумму непростых делителей числа.
# Метод 2 Найти количество цифр числа, меньших 3
# Метод 3 Найти количество чисел, не являющихся делителями исходного
# числа, не взамно простых с ним и взаимно простых с суммой простых
# цифр этого числа.

#1
def prime(num)
  return true if num==2
  return false if num<=1

  Math.sqrt(num).to_int.downto(2).each do |x|
    return false if (num%x)==0
  end
  true
end

def sum_prime_divide(num)
  s=0
  2.upto(num) do |i|
    if !prime(i) && num%i==0
      s+=i
    end
  end

  return s
end


puts sum_prime_divide(27)

#2
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

#3 Найти количество чисел, не являющихся делителями исходного
# # числа, не взамно простых с ним и взаимно простых с суммой простых
# # цифр этого числа.
#3
def sum_prime_digits(number) # сумма простых цифр числа
  sum=0
  number.digits.each { |i| sum += i if prime(i) }
  sum
end
def count_unique(number)
  count = 0
  number.downto(2).each { |i| count += 1 unless ((number % i).zero?) || i.gcd(number) != 1 || i.gcd(sum_prime_digits(number)) == 1 } # gcd - встроенный нод
  count
end

puts count_unique(34)