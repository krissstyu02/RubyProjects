# frozen_string_literal: true
require_relative 'add_controller'
require 'logger'
class UpdateStudentController<AddStudentController
  private_class_method :new
  def initialize(student_list, student_id)
    super(student_list)
    @student_id = student_id
    @logger = Logger.new('controller_update.log') # Указывает путь и имя файла для логов
  end

  def add_view(view)
    @logger.info('Adding view to update student controller')
    super(view)
    student = @student_list.student_by_id(@student_id)
    @view.set_student(student,get_editable_fields)
  end

  def save_student(student)
    @logger.info('Saving updated student')
    puts student.to_hash
    @student_list.replace_student(@student_id, student)
  end

  private
  def get_editable_fields; end

end
