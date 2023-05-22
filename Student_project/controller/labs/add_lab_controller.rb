# frozen_string_literal: true

require_relative '../../lab_model/labs'
class AddLabController
  def initialize(student_lab)
    @student_lab = student_lab
  end

  def add_view(view)
    @view = view
    @view.set_lab
  end
  def execute
    @view.execute
  end
  def save_lab(lab)
    @student_lab.add_lab(lab)
  end

  def next_number_lab
    @student_lab.get_next_number
  end

  def validate_fields(fields)
    begin
      lab = Lab.new(**fields)
      return lab

    rescue ArgumentError => e
      return nil
    end
  end

end