# frozen_string_literal: true
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