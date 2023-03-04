require_relative 'student'

student1 = Student.new('Петров', 'Павел', 'Иванович')
student2 = Student.new('Арбузов', 'Алексей', 'Михайлович', { id: 1, telegram: '@arbalex',phone:'89187652345' })
student3 = Student.new('Гавриш', 'Анна', 'Николаевна', { id:2, phone: '+79678543657', email: 'gavrish_anna_99@mail.ru', git: '@anna99' })


puts student1
puts student2
puts student3


puts Student.valid_phone?('+79678543657')
puts Student.valid_phone?('7865436789056')

puts Student.valid_account?('@arbalex')
puts Student.valid_email?('@fain@mail')

puts student3.contact?

student1.set_contacts({telegram: '@user2000'})
puts student1# frozen_string_literal: true

