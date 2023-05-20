require_relative 'models/student'
require_relative 'models/student_short'
require_relative 'data/containers/dataTable'
require 'mysql2'
require_relative './data/student_db_adapter'
require_relative 'views/interface'

def read_from_txt(file_path)
  raise ArgumentError, 'File not found' unless File.exist?(file_path)
data = [
      ["Apple", "@apple", "apple@example.com"],
      ["Nanana", "@banana", "banana@example.com"],
      ["Cherry", "@cherry", "cherry@example.com"],
      ["Durian", "@durian", "durian@example.com"],
      ["Elderberry", "@elderberry", "elderberry@example.com"],
      ["Gig", "@fig", "fig@example.com"],
      ["Grape", "@grape", "grape@example.com"],
      ["Honeydew", "@honeydew", "honeydew@example.com"],
      ["Rackfruit", "@jackfruit", "jackfruit@example.com"],
      ["Kiwi", "@kiwi", "kiwi@example.com"]
    ]
    data.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        @table.setItemText(i, j, cell)
      end
    end
  stud_file = File.open(file_path, 'r')
  result = ''
  stud_file.each do |line|
    result << line
  end
  stud_file.close
  students_list = []
  stud_list = JSON.parse(result)

  stud_list['StudentList'].each do |obj|
    students_list << Student.init_from_json(obj.to_json)
  end
  students_list
end

def write_to_txt(file_path, student_list)
  result = '{"StudentList":['
  student_list.each do |student|
    result += student.to_json + ","
  end
  result = result.chop + "]}"
  File.write(file_path, result)
end

# student1 = Student.new('Гавриш', 'Геннадий', 'Алексеевич')
# student2 = Student.new('Петровв', 'Иван', 'Борисович', { id: 40, telegram: '@ivan45' })
# student3=StudentShort.new(student2)
# puts(student3.contact)
#
# student_list = [student1, student2]
# puts read_from_txt('/home/kristina/RubymineProjects/RubyProjects/Student_project/student_list.txt')
# write_to_txt('/home/kristina/RubymineProjects/RubyProjects/Student_project/student_list2.txt', student_list)

# test = [ [1,'One'], [2,'Two']]
# test_table = DataTable.new(test)
# puts test_table
# puts test_table.get_element(0,1)


# Создаем соединение с базой данных
# client = Mysql2::Client.new(
#   :host => 'localhost',
#   :username => 'root',
#   :password => 'Kris110902Star',
#   :database => 'student_db'
# )
#
# # Выполняем SELECT-запрос
# results = client.query('SELECT * FROM students')
#
# # Выводим результаты на экран
# results.each do |row|
#   puts row.inspect
# end


# Создаем экземпляр класса StudentListDB
student_list = StudentList_db_Adapter.new

# Тест метода student_by_id
student = student_list.student_by_id(1)
puts student.inspect

# # Тест метода add_student
# student2 = Student.new('Антонов', 'Иван', 'Борисович', { id: 1, telegram: '@ivan45' })
# id = student_list.add_student(student2)
# puts "New student id: #{id}"

# # Тест метода replace_student

# student_list.replace_student(4,student2)



# # Тест метода remove_student
# student_list.remove_student(5)
# deleted_student = student_list.student_by_id(id)
# puts "Удален студент"+deleted_student.inspect

# app = FXApp.new
# Window.new(app)
# app.create
# app.run

require_relative 'models/student_lab'
require_relative 'lab_model/labs'
lab1 = Lab.new(**{number: 3, name: 'Лаба333', date_load: '2023-10-21'})
db=StudentLab.new
puts db.get_lab_by_number(2)
# db.add_lab(lab1)

db.remove_lab(3)
puts db.get_next_number
puts db.lab_count


db.replace_lab(1,lab1)
puts db.get_lab_by_number(1)

# просмотреть и проверить все методы во 2 адаптере и идем дальше