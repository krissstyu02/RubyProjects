# frozen_string_literal: true
require_relative 'add_controller'
class UpdateStudentController<AddStudentController

  def initialize(student_list, student_id)
    super(student_list)
    @student_id = student_id
  end

  def add_view(view)
    super(view)
    student = @student_list.student_by_id(@student_id)
    @view.set_student(student)
  end

  def save_student(student)
    puts student.to_hash
    @student_list.replace_student(@student_id, student)
  end

end
