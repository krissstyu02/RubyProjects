# frozen_string_literal: true

require_relative 'student'
require_relative 'student_short'
require_relative 'data_list_student_short'
require_relative 'student_files_base'
require_relative 'student_list_txt'
require_relative 'student_list_json'
require_relative 'student_list_yaml'
require 'json'

student1 = Student.new('Андреев', 'Анжрей', 'Алексеевич')
student2 = Student.new('Антонов', 'Антон', 'Баракович', { id: 1, telegram: '@andr_usa' })

puts '--------------------------------'
puts 'Тест StudentsList (JSON):'

stud_list_json = StudentListBase.new(StudentListJSON.new)
stud_list_json.add_student(student1)
stud_list_json.add_student(student2)
stud_list_json.write_to_file('./lr2/tests/student_2.json')

stud_list_json.read_from_file('./lr2/tests/student.json')

puts "Успешно записано и прочитано #{stud_list_json.student_count} студентов:"

puts '--------------------------------'
puts 'Тест StudentsList (YAML):'

stud_list_yaml = StudentListBase.new(StudentListYAML.new)
stud_list_yaml.add_student(student1)
stud_list_yaml.add_student(student2)

stud_list_yaml.write_to_file('./lr2/tests/student_2.yaml')

stud_list_yaml.read_from_file('./lr2/tests/student.yaml')

puts "Успешно записано и прочитано #{stud_list_yaml.student_count} студентов:"


puts '--------------------------------'
puts 'Тест StudentsList (TXT):'

stud_list_txt = StudentListBase.new(StudentListTxt.new)
stud_list_txt.add_student(student1)
stud_list_txt.add_student(student2)

stud_list_txt.write_to_file('./lr2/tests/student_2.txt')

stud_list_txt.read_from_file('./lr2/tests/student.txt')

puts "Успешно записано и прочитано #{stud_list_txt.student_count} студентов:"