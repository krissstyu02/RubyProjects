# frozen_string_literal: true
require 'date'
class Lab
  def initialize(id: nil, name: nil, date_load: nil,themes:nil,tasks:nil)
    raise ArgumentError, "Required fields: name, number and date!" if id.nil? || name.nil?|| date_load.nil?
    @id = id
    @name = name
    raise ArgumentError, 'Вы не можете выдать эту лабораторную работу раньше предыдущей!' unless Lab.validate_date?(date_load)
    @date_load = date_load
    @themes = themes
    @tasks = tasks
  end

  attr_reader :id, :name, :date_load, :tasks,:themes


  def to_s
    res = "Lab#{number} #{name} #{date_load}"
  end


  def to_hash
    info_hash = {}
    %i[id name date_load themes tasks].each do |field|
      info_hash[field] = send(field)
    end
    info_hash
  end


  def self.validate_date?(date)
    begin
      Date.parse(date.to_s)
      return true
    rescue ArgumentError
      return false
    end
  end


  def self.validate_date_range?(new_date, old_date)
    parsed_new_date = Date.parse(new_date)
    parsed_new_date > old_date
  end



end
