# frozen_string_literal: true

class Lab
  def initialize(number: nil, name: nil, date_load: nil)
    raise ArgumentError, "Required fields: name, number and date!" if number.nil? || name.nil?|| date_load.nil?
    @number = number
    @name = name
    @date_load = date_load
  end

  attr_reader :number, :name, :date_load


  def to_s
    res = "Lab#{number} #{name} #{date_load}"
  end

  def to_hash
    info_hash = {}
    %i[number name date_load].each do |field|
      info_hash[field] = send(field)
    end
    info_hash
  end




end
