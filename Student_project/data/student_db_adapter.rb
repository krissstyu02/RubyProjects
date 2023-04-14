require 'mysql2'
require_relative '../models/student'
require_relative '../models/student_short'
require_relative '../data/containers/data_list_student_short'
require_relative 'db_connection'

class StudentList_db_Adapter
  def initialize
    @db = DBConnection.instance
  end

  def student_by_id(student_id)
    result = @db.query("SELECT * FROM students WHERE id = #{student_id}").first
    return Student.from_hash(result.transform_keys(&:to_sym)) if result
    nil
  end

  def add_student(student)
    stmt = @db.prepare('INSERT INTO students (first_name, last_name, paternal_name, phone, telegram, email, git) VALUES (?, ?, ?, ?, ?, ?, ?)')
    stmt.execute(*student_fields(student))
    @db.last_id
  end

  def remove_student(student_id)
    @db.query("DELETE FROM students WHERE id = #{student_id}")
  end

  def replace_student(student_id, student)
    stmt = @db.prepare('UPDATE students SET first_name = ?, last_name = ?, paternal_name = ?, phone = ?, telegram = ?, email = ?, git = ? WHERE id = ?')
    stmt.execute(*student_fields(student), student_id)
  end

  def student_count
    @db.query('SELECT COUNT(id) FROM students').first.values.first
  end

  def get_k_n_student_short_list(k,n)
    students = @db.prepare('SELECT * FROM students LIMIT ? OFFSET ?').execute((k-1)*n,n)
    slice = students.map { |h| StudentShort.new(Student.from_hash(h)) }
    DataListStudentShort.new(slice)
  end

  private
  attr_accessor :client

  def student_fields(student)
    [student.first_name, student.last_name, student.paternal_name, student.phone, student.telegram, student.email, student.git]
  end
end

