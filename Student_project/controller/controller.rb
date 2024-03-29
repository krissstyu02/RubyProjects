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
require_relative '../models/student'
require_relative 'update_controller'
require_relative 'update/update_name_controller'
require_relative 'update/update_git_controller'
require_relative 'update/update_contact_controller'
require 'fox16'
include Fox
require 'logger'


class StudentListController
  def initialize(view)
    @view = view
    @data_list = DataListStudentShort.new([])
    @data_list.add_observer(@view)
    @student_list = StudentList.new(StudentList_db_Adapter.new)
    adapter_path = '/home/kristina/RubymineProjects/RubyProjects/Student_project/test_files/student.yaml'
    # @student_list = StudentList.new(StudentFilesAdapter.new(StudentListYAML.new, adapter_path))
    @logger = Logger.new('controller.log') # Указывает путь и имя файла для логов
  end




  def refresh_data(k_page, number_students)
    begin
    @logger.info("Refreshing data with k_page=#{k_page} and number_students=#{number_students}")
    @data_list = @student_list.get_k_n_student_short_list(k_page, number_students, @data_list)
    rescue Mysql2::Error => e
      @logger.error("Error occurred while refreshing data: #{e.message}")
      puts "No connection to DB: #{e.message}"
      exit(false)
    else
      @logger.info("Data refreshed successfully with k_page=#{k_page} and number_students=#{number_students}")
  end
    @view.update_count_students(@student_list.student_count)
  end


  def student_add
    @logger.info('Add student')
    controller = AddStudentController.new(@student_list)
    show_dialog(controller)
  end

  private
  #изменение студента
  def get_student_id(index)
    @data_list.select(index)
    id = @data_list.get_select
    @data_list.clear_selected
    id
  end

  public
  def student_change_name(index)
    @logger.info('Changing student name')
    puts 'update name'
    id = get_student_id(index)
    controller = ChangeStudentNameController.new(@student_list, id)
    show_dialog(controller)
  end

  def student_change_git(index)
    @logger.info('Changing student Git')
    puts 'update git'
    id = get_student_id(index)
    controller = ChangeStudentGitController.new(@student_list, id)
    show_dialog(controller)
  end

  def student_change_contact(index)
    @logger.info('Changing student contact')
    puts 'update name'
    id = get_student_id(index)
    controller = ChangeStudentContactController.new(@student_list, id)
    show_dialog(controller)
  end


  def student_delete(indexes)
    @data_list.select(*indexes)
    id_list = @data_list.get_select
    @data_list.clear_selected

    id_list.each{|student_id| @student_list.remove_student(student_id)}
    @view.refresh
    @logger.info("Deleted students with IDs: #{id_list.join(', ')}")
  end

  private
  def show_dialog(controller)
    # controller = AddStudentController.new(@student_list)
    view = CreateStudentDialog.new(@view, controller)
    controller.add_view(view)
    controller.execute
    @view.refresh
  end


end
