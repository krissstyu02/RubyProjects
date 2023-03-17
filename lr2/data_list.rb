class Data_list

  attr_reader :selected

  def initialize(data)
    @data = data
    @selected = []
  end

  def [](index)
    @data[index]
  end

  def select(number)
    @selected << number
  end

  def get_selected
    @selected
  end

  def get_names
    raise NotImplementedError, "get_names нужно реализовать в классе наследнике"
  end

  def get_data
    raise NotImplementedError, "get_data must нужно реализовать в классе наследнике"
  end
end