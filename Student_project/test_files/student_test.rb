# frozen_string_literal: true

require_relative '../models/student'
require_relative '../models/student_short'
require_relative '../data/containers/data_list_student_short'
require_relative '../data/files/student_files_base'
require_relative '../data/files/strategy/student_list_txt'
require_relative '../data/files/strategy/student_list_json'
require_relative '../data/files/strategy/student_list_yaml'
require_relative '../data/student_list'
require_relative '../data/student_files_adapter'
require 'json'

# student1 = Student.new('Андреев', 'Анжрей', 'Алексеевич')
# student2 = Student.new('Антонов', 'Антон', 'Баракович', { id: 1, telegram: '@andr_usa' })
#
# puts '--------------------------------'
# puts 'Тест StudentsList (JSON):'
#
# stud_list_json = StudentListBase.new(StudentListJSON.new)
# stud_list_json.add_student(student1)
# stud_list_json.add_student(student2)
# stud_list_json.write_to_file('./Student_project/test_files/student_2.json')
#
# stud_list_json.read_from_file('./Student_project/test_files/student.json')
#
# puts "Успешно записано и прочитано #{stud_list_json.student_count} студентов:"
#
# puts '--------------------------------'
# puts 'Тест StudentsList (YAML):'
#
# stud_list_yaml = StudentListBase.new(StudentListYAML.new)
# stud_list_yaml.add_student(student1)
# stud_list_yaml.add_student(student2)
#
# stud_list_yaml.write_to_file('./Student_project/test_files/student_2.yaml')
#
# stud_list_yaml.read_from_file('./Student_project/test_files/student.yaml')
#
# puts "Успешно записано и прочитано #{stud_list_yaml.student_count} студентов:"
#
#
# puts '--------------------------------'
# puts 'Тест StudentsList (TXT):'
#
# stud_list_txt = StudentListBase.new(StudentListTxt.new)
# stud_list_txt.add_student(student1)
# stud_list_txt.add_student(student2)
#
# stud_list_txt.write_to_file('./Student_project/test_files/student_2.txt')
#
# stud_list_txt.read_from_file('./Student_project/test_files/student.txt')
#
# puts "Успешно записано и прочитано #{stud_list_txt.student_count} студентов:"

def test_adapter(student_rep)
  puts "В репозитории #{student_rep.student_count} студентов."
  puts "Студент с id=1: #{student_rep.student_by_id(1)}"
  student_rep.remove_student(2)
  puts "Теперь в репозитории #{student_rep.student_count} студента."
  student = Student.new('Антонов', 'Антон', 'Баракович', { id: 1, telegram: '@andr_usa' })
  added_id=student_rep.add_student(student)
  puts "Теперь в репозитории #{student_rep.student_count} студентов."
  student.git = '@heey'
  puts student.to_s

  student_rep.replace_student(1,student)
  puts "Измененный студент: #{student_rep.student_by_id(6)}"
  puts 'Страница 1:'
  puts student_rep.get_k_n_student_short_list(1, 2).get_data.inspect
end

puts '=> Тест StudentRepository (JSON) <='
rep_json =StudentList.new(StudentFilesAdapter.new(StudentListJSON.new, './Student_project/test_files/student.json'))
test_adapter(rep_json)