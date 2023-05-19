# frozen_string_literal: true

require_relative '../lab_model/labs'
require_relative '../data/containers/data_list_lab'
require_relative '../data/db_connection'
class StudentLab
  def initialize
    self.db =DBConnection.instance
  end

  def get_lab_by_number(id_lab)
    hash = db.execute('SELECT * FROM labs WHERE number = ?', id_lab).first
    return nil if hash.nil?
    Lab.new(**hash.transform_keys(&:to_sym))
  end

  # def student_by_id(student_id)
  #   student_id = student_id.first.to_i
  #   result = @db.query("SELECT * FROM students WHERE id = #{student_id}").first
  #   return Student.from_hash(result.transform_keys(&:to_sym)) if result
  #   nil
  # end
  def add_lab(lab)
    # db.query('insert into labs (number, name, date_load) VALUES (?, ?, ?)', *lab_fields(lab)).first
    stmt = db.prepare('INSERT INTO labs (number,name,date_load) VALUES (?, ?, ?)')
    puts(*lab_fields(lab))
    stmt.execute(*lab_fields(lab))

  end

  def remove_lab(id_lab)
    db.execute('DELETE FROM labs WHERE number = ?', id_lab)
  end
  def replace_lab(id_lab, lab)
    db.execute('UPDATE labs SET name=?, date_load=? WHERE number=?',*lab_fields(lab), id_lab)
  end
  def get_lab_list(data_list=nil) #получение все лаб в базе
    labs_hash = db.execute('SELECT * FROM labs')
    labs = labs_hash.map{|lab| Lab.new(**lab.transform_keys(&:to_sym))}

    return DataListStudentLab.new(labs) if data_list.nil?
    data_list.replace_objects(labs)
    data_list
  end

  def get_next_number
    lab_count+1
  end

  def lab_count
    db.results_as_hash=false
    res=db.execute("Select COUNT(*) from labs").first[0]
    db.results_as_hash=true
    res
  end

  private
  attr_accessor :db
  def lab_fields(lab)
    [lab.number, lab.name, lab.date_load]
  end
end