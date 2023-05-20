# frozen_string_literal: true

require_relative '../lab_model/labs'
require_relative '../data/containers/data_list_lab'
require_relative '../data/db_connection'
class StudentLab
  def initialize
    self.db =DBConnection.instance
  end

  def get_lab_by_number(id_lab)
    id_lab = id_lab
    hash = @db.query("SELECT * FROM labs WHERE number = #{id_lab}").first
    return nil if hash.nil?
    Lab.new(**hash.transform_keys(&:to_sym))
  end


  def add_lab(lab)
    # db.query('insert into labs (number, name, date_load) VALUES (?, ?, ?)', *lab_fields(lab)).first
    stmt = db.prepare('INSERT INTO labs (number,name,date_load) VALUES (?, ?, ?)')
    puts(*lab_fields(lab))
    stmt.execute(*lab_fields(lab))

  end

  def remove_lab(id_lab)
    db.query("DELETE FROM labs WHERE number = #{id_lab}")
  end

  #ну дальше не работает(((
  # def replace_lab(id_lab, lab)
  #   fields=*lab_fields(lab)
  #   puts fields[1],fields[2]
  #   name = fields[1].nil? ? 'NULL' : fields[3]
  #   date_load = fields[2].nil? ? 'NULL' : "'#{fields[4]}'"
  #
  #   db.query("UPDATE labs SET name = '#{name}',
  #                              date_load = '#{date_load}',
  #                              WHERE number = #{id_lab}")
  #
  # end


  def replace_lab(id_lab, lab)
    sql = 'UPDATE labs SET name=?, date_load=? WHERE number=?'
    fields=*lab_fields(lab)
    db.prepare(sql).execute(fields[1],fields[2], id_lab)
  end



  def get_lab_list(data_list=nil) #получение все лаб в базе
    labs_hash = db.query('SELECT * FROM labs')
    labs = labs_hash.map{|lab| Lab.new(**lab.transform_keys(&:to_sym))}
    return DataListStudentLab.new(labs) if data_list.nil?
    data_list.replace_objects(labs)
    data_list
  end

  def get_next_number
    lab_count+1
  end

  def lab_count
    res=db.query('SELECT COUNT(number) FROM labs').first.values.first
    res
  end

  private
  attr_accessor :db
  def lab_fields(lab)
    [lab.number, lab.name, lab.date_load]
  end
end