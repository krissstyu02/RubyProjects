# frozen_string_literal: true
require_relative 'DataList'
require_relative 'dataTable'

class DataListStudentLab<DataList
  public_class_method :new

  protected
  def get_fields(object)
    [object.id, object.name, object.date_load]
  end

end
