# frozen_string_literal: true

#Метод 1 Найти сумму непростых делителей числа.
#
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