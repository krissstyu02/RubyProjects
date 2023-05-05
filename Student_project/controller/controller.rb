# frozen_string_literal: true
#
require_relative '../views/interface'
require_relative '../data/student_list'
require_relative '../data/student_db_adapter'
class StudentListController
  def initialize(view)
    @view = view
  end

  def view_create
    @student_list = StudentList.new(StudentList_db_Adapter.new)
  end

  def show_view
    @view.create.run
  end
end
