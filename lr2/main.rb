require_relative 'student'
require_relative 'student_short'

def read_from_txt(file_path)
  raise ArgumentError, 'File not found' unless File.exist?(file_path)

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


student1 = Student.new('Иванов', 'Иван', 'Иванович')
student2 = Student.new('Петров', 'Алексей', 'Николаевич',  {id: 1, telegram: '@alex'} )

student_list = [student1, student2]

puts read_from_txt('/home/kristina/RubymineProjects/RubyProjects/lr2/student_list.txt')
write_to_txt('/home/kristina/RubymineProjects/RubyProjects/lr2/student_list2.txt', student_list)