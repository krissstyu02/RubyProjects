class Data_list

def initialize(*elements)
  @data = elements.sort
  @selected = []
end

def [](index)
  @data[index]
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

def each
  @data.each { |element| yield element }
end

def get_selected
  @selected
end
  def get_names
    raise NotImplementedError, "get_names нужно реализовать в классе наследнике"
  end

  def get_data
    raise NotImplementedError, "get_data нужно реализовать в классе наследнике"
  end

end

