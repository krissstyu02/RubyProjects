class StudentListBase

  attr_writer :data_type

  # конструктор
  def initialize(data_type)
    self.students = []
    self.cur_id = 1
    self.data_type = data_type
  end

  # чтение из файла
  def read_from_file(file_path)
    list = data_type.str_to_list(File.read(file_path))
    self.students = list.map { |h| Student.from_hash(h) }
    update_cur_id
  end

  # запись в файл
  def write_to_file(file_path)
    list = students.map(&:to_hash)
    File.write(file_path, data_type.list_to_str(list))
  end

  # найти студента по айди
  def student_by_id(student_id)
    students.detect { |s| s.id == student_id }
  end

  # Получить список k по счету n  объектов класса Student_short
  def get_k_n_student_short_list(page, count, current_data_list)
    offset = (page - 1) * count # сдвиг элементов массива
    slice = students[offset, count].map { |s| StudentShort.new(s) }

    return DataListStudentShort.new(slice) if current_data_list.nil?
    current_data_list.replace_objects(slice)
    current_data_list
  end

  # сортировка по фамилии и инициалам
  def sorted
    students.sort_by(&:last_name_and_initials)
  end

  # добавление студента
  def add_student(student)
    student.id = cur_id
    students << student
    self.cur_id += 1
  end

  # заменить студента
  def replace_student(student_id, student)
    idx = students.find_index { |s| s.id == student_id }
    students[idx] = student
  end
  #удалили студента((
  def remove_student(student_id)
    students.reject! { |s| s.id == student_id }
  end

  # число студентов
  def student_count
    students.size
  end

  #вспомогательные функции


  # найти студента по фамилии и инциалам
  def student_by_name(student_name)
    students.filter { |s| s.last_name_and_initials == student_name }
  end

  protected

  attr_accessor :students, :cur_id

  private
  attr_reader :data_type

  # Метод для обновлении информации в cur_id
  def update_cur_id
    self.cur_id = students.max_by(&:id).id.to_i + 1
  end


end# frozen_string_literal: true

