# frozen_string_literal: true
require_relative 'update_controller'
class ChangeStudentGitController<UpdateStudentController
  public_class_method :new
  def get_editable_fields
    [:git]
  end

  end

