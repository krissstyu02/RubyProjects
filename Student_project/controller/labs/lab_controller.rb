# frozen_string_literal: true
require_relative '../../models/student_lab'
require_relative '../../data/containers/data_list_lab'
require_relative 'add_lab_controller'
require_relative '../../views/create_lab_dialog'
class StudentLabController
  def initialize(view)
    @view = view
    @data_list  = DataListStudentLab.new([])
    @data_list.add_observer(@view)
    @student_lab = StudentLab.new
  end

  def refresh_data
    begin
      @data_list = @student_lab.get_lab_list(@data_list)
    rescue Mysql2::Error => e
      puts "No connection to DB: #{e.message}"
      exit(false)
    end
  end

  def add_lab
    controller = AddLabController.new(@student_lab)
    show_dialog(controller)
  end

  def show_dialog(controller)
    view = CreateLabDialog.new(@view, controller)
    controller.add_view(view)
    controller.execute

    @view.refresh
  end

  def get_count_lab
    @student_lab.lab_count
  end
  def delete_lab
    @student_lab.remove_lab(get_count_lab)
    @view.refresh
  end

  end
