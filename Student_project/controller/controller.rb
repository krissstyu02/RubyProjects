# frozen_string_literal: true
#
require_relative '../views/interface'
require_relative '../data/student_list'
require_relative '../data/student_db_adapter'
require_relative'../data/containers/data_list_student_short'
require_relative '../data/student_files_adapter'
require_relative 'add_controller'
require_relative '../views/dialog_create_student'
require_relative '../data/files/strategy/student_list_json'
require_relative '../data/files/strategy/student_list_txt'
require_relative '../data/files/strategy/student_list_yaml'
require 'fox16'
include Fox
class StudentListController
  def initialize(view)
    @view = view
    @data_list = DataListStudentShort.new([])
    @data_list.add_observer(@view)
    # @student_list = StudentList.new(StudentList_db_Adapter.new)
    adapter_path = '/home/kristina/RubymineProjects/RubyProjects/Student_project/test_files/student.yaml'
    @student_list = StudentList.new(StudentFilesAdapter.new(StudentListYAML.new, adapter_path))
  end



  def refresh_data(k_page, number_students)
    begin
    @data_list = @student_list.get_k_n_student_short_list(k_page, number_students, @data_list)
    rescue Mysql2::Error => e
      puts "No connection to DB: #{e.message}"
      exit(false)
  end
    @view.update_count_students(@student_list.student_count)
  end

end
