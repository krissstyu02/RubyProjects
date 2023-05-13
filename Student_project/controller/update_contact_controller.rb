# frozen_string_literal: true
require_relative 'update_controller'
class ChangeStudentContactController<UpdateStudentController
  public_class_method :new
  def get_editable_fields
    [:phone, :email, :telegram]
  end

end
