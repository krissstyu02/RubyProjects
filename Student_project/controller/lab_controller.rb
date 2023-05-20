# frozen_string_literal: true
require_relative '../models/student_lab'
require_relative '../data/containers/data_list_lab'
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

  end
