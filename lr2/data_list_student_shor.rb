# frozen_string_literal: true

require_relative 'data_list'

class Data_List_Student_Short < Data_list

def set_data(new_data)
  @data = new_data
end

def select(number)
  @selected << @data[number].id
end

def get_names
  %w[id surname git contact]
end

def get_data
  Data_table.new([@data])
end

end
