
require 'mysql2'
require_relative '../models/student'

class StudentListDB
  def initialize(db_config)
    self.client = Mysql2::Client.new(db_config)
  end

  def student_by_id(student_id)
    client.query("SELECT * FROM students WHERE id = #{student_id}").first.tap do |result|
      return Student.from_hash(result) if result
    end
    nil
  end

  def add_student(student)
    stmt = client.prepare('INSERT INTO students (first_name, last_name, paternal_name, phone, telegram, mail, git) VALUES (?, ?, ?, ?, ?, ?, ?)')
    stmt.execute(*student_fields(student))
    client.last_id
  end

  def remove_student(student_id)
    client.query("DELETE FROM students WHERE id = #{student_id}")
  end

  def replace_student(student_id, student)
    stmt = client.prepare('UPDATE students SET first_name = ?, last_name = ?, paternal_name = ?, phone = ?, telegram = ?, mail = ?, git = ? WHERE id = ?')
    stmt.execute(*student_fields(student), student_id)
  end

  def student_count
    client.query('SELECT COUNT(id) FROM students').first.values.first
  end

  def get_k_n_student_short_list(k, n)
    students = client.query("SELECT * FROM students LIMIT #{n} OFFSET #{(k-1)*n}")
    slice = students.map { |h| StudentShort.new(Student.from_hash(h)) }
    DataListStudentShort.new(slice)
  end

  private

  attr_accessor :client

  def student_fields(student)
    [student.first_name, student.last_name, student.paternal_name, student.phone, student.telegram, student.mail, student.git]
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
puts db.student_by_id(1)


