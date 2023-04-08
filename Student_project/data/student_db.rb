
require 'mysql2'
require_relative '../models/student'
require_relative '../models/student_short'
require_relative '../data/containers/data_list_student_short'

class StudentListDB
  def initialize(db_config)
    self.client = Mysql2::Client.new(db_config)
  end

  def student_by_id(student_id)
    result = client.query("SELECT * FROM students WHERE id = #{student_id}").first
    return Student.from_hash(result.transform_keys(&:to_sym)) if result
    nil
  end

  def add_student(student)
    stmt = client.prepare('INSERT INTO students (first_name, last_name, paternal_name, phone, telegram, email, git) VALUES (?, ?, ?, ?, ?, ?, ?)')
    stmt.execute(*student_fields(student))
    client.last_id
  end

  def remove_student(student_id)
    client.query("DELETE FROM students WHERE id = #{student_id}")
  end

  def replace_student(student_id, student)
    stmt = client.prepare('UPDATE students SET first_name = ?, last_name = ?, paternal_name = ?, phone = ?, telegram = ?, email = ?, git = ? WHERE id = ?')
    stmt.execute(*student_fields(student), student_id)
  end

  def student_count
    client.query('SELECT COUNT(id) FROM students').first.values.first
  end


  def get_k_n_student_short_list(k,n)
    students = client.prepare('SELECT * FROM students LIMIT ? OFFSET ?').execute((k-1)*n,n)
    slice = students.map { |h| StudentShort.new(Student.from_hash(h)) }
    DataListStudentShort.new(slice)
  end

  private

  attr_accessor :client

  def student_fields(student)
    [student.first_name, student.last_name, student.paternal_name, student.phone, student.telegram, student.email, student.git]
  end
end

db_config = {
  host: 'localhost',
  username: 'root',
  password: 'Kris110902Star',
  database: 'student_db'
}

db = StudentListDB.new(db_config)
puts db.student_count

student1 = Student.new('Гавриш', 'Геннадий', 'Алексеевич')
# db.add_student(student1)
puts db.student_by_id(1)
# puts db.remove_student(3)
# db.replace_student(2,student1)
# puts db.get_k_n_student_short_list(1,2)


