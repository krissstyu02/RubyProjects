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
    student_id = student_id.first.to_i
    result = @db.query("SELECT * FROM students WHERE id = #{student_id}").first
    return Student.from_hash(result.transform_keys(&:to_sym)) if result
    nil
  end


  def add_student(student)
    stmt = @db.prepare('INSERT INTO students (first_name, last_name, paternal_name, phone,
    telegram, email, git) VALUES (?, ?, ?, ?, ?, ?, ?)')
    stmt.execute(*student_fields(student))
    @db.last_id
  end

  def remove_student(student_id)
    @db.query("DELETE FROM students WHERE id = #{student_id}")
  end


  # def replace_student(student_id, student)
  #   query = <<~SQL
  #   UPDATE students
  #   SET first_name = ?,
  #       last_name = ?,
  #       paternal_name = ?,
  #       phone = ?,
  #       telegram = ?,
  #       email = ?,
  #       git = ?
  #   WHERE id = ?
  #   SQL
  #
  #   stmt = @db.prepare(query)
  #   stmt.execute(*student_fields(student), student_id.first.to_i)
  # end

  def replace_student(student_id, student)
    fields = *student_fields(student)
    puts fields
    puts(student_id)

    phone_value = fields[3].nil? ? 'NULL' : fields[3]
    telegram_value = fields[4].nil? ? 'NULL' : "'#{fields[4]}'"
    email_value = fields[5].nil? ? 'NULL' : "'#{fields[5]}'"
    git_value = fields[6].nil? ? 'NULL' : "'#{fields[6]}'"

    @db.query("UPDATE students SET first_name = '#{fields[1]}',
                               last_name = '#{fields[0]}',
                               paternal_name = '#{fields[2]}',
                               phone = #{phone_value},
                               telegram = #{telegram_value},
                               email = #{email_value},
                               git = #{git_value}
                               WHERE id = #{student_id.first.to_i}")
  end


  #
  # def replace_student(student_id, student)
  #   query = <<~SQL
  #   UPDATE students
  #   SET first_name = ?,
  #       last_name = ?,
  #       paternal_name = ?,
  #       phone = ?,
  #       telegram = ?,
  #       email = ?,
  #       git = ?
  #   WHERE id = ?
  #   SQL
  #
  #   stmt = @db.prepare(query)
  #   stmt.execute(*student_fields(student), student_id)
  # end




  def student_count
    @db.query('SELECT COUNT(id) FROM students').first.values.first
  end

  def get_k_n_student_short_list(k,n,data_list)
    students = @db.query("SELECT * FROM students LIMIT #{(k-1)*n}, #{n}")
    students2=students.map(&:to_h)
    slice = students2.map { |h| StudentShort.new(Student.from_hash(h.transform_keys(&:to_sym))) }
    DataListStudentShort.new(slice) if data_list.nil?
    # student = student_list.student_by_id(1)
    # puts student.inspect
    data_list.replace_objects(slice)
    puts data_list
    data_list
  end

  private
  attr_accessor :client

  def student_fields(student)
    [student.first_name, student.last_name, student.paternal_name, student.phone, student.telegram, student.email, student.git]
  end
end

