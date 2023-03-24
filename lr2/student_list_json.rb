require_relative 'student_files_base'
require 'json'
class StudentListJSON < StudentListBase
  public_class_method :new

  protected

  def str_to_list(str)
    JSON.parse(str, { symbolize_names: true })
  end

  def list_to_str(list)
    JSON.generate(list)
  end
end# frozen_string_literal: true

