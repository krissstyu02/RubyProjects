# frozen_string_literal: true

class DataList

  private_class_method :new
  #Реализовать сеттер для массива объектов
  attr_writer :objects_list

  def initialize(objects)
    self.objects_list = objects
    self.selected_objects = []
  end

  def select(number)
    selected_objects.append(number)
  end

  def clear_select
    self.selected_objects = []
  end

  def get_selected
    return [] if selected_objects.empty?

    selected_id_list = []
    selected_objects.each do |num|
      selected_id_list.append(objects_list[num].id)
    end
    selected_id_list
  end

# применение паттерна
def get_data
  result = []
  id = 0
  objects_list.each do |obj|
    row = []
    row << id
    row.push(*table_fields(obj))
    result << row
    id += 1
  end
  DataTable.new(result)
end

protected

def get_names; end

# данный метод необходимо переопределять у наследников
def table_fields(object)
  []
end

private

attr_reader :objects_list
attr_accessor :selected_objects
end