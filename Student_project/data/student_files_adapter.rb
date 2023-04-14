# frozen_string_literal: true
# frozen_string_literal: true
require_relative 'student_files_base'
class StudentFilesAdapter
  def initialize(data_type, file_path)
    @file = StudentListBase.new(data_type)
    @file.read_from_file(file_path)
    @file_path = file_path
  end
  # получить студента по id
  def student_by_id(student_id)
    @file.student_by_id(student_id)
  end

  #добавление студента
  def add_student(student)
    @file.add_student(student)
    @file.write_to_file(@file_path)
  end

  #удаление студента по id
  def remove_student(student_id)
    @file.remove_student(student_id)
    @file.write_to_file(@file_path)
  end

  #замена студента по id
  def replace_student(student_id, student)
    @file.replace_student(student,student_id)
    @file.write_to_file(@file_path)
  end

  #подсчет количества студентов
  def student_count
    @file.student_count
  end

  #полуение n элементов page страницы
  def get_k_n_student_short_list(page,n, data_list:nil)
    @file.get_k_n_student_short_list(page, n, data_list)
  end
end
