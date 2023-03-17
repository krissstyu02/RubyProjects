class Data_list

  def initialize(*elements)
    @data = elements.sort
    @selected = []
  end

  def [](index)
    @data[index]
  end

  def each
    @data.each { |element| yield element }
  end

  def size
    @data.size
  end

  def self.create(*elements)
    new(*elements)
  end

  def select(number)
    @selected << number
  end
end

def get_selected
  @selected
end

def get_names
  raise NotImplementedError, "Данный метод необходимо реализовать в классе наследнике"
end

def get_data
  raise NotImplementedError, "Данный метод необходимо реализовать в классе наследнике"
end

