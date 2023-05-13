# frozen_string_literal: true

require_relative '../update_controller'
class ChangeStudentNameController<UpdateStudentController
  public_class_method :new
  def get_editable_fields
    [:first_name, :last_name, :paternal_name]
  end

end