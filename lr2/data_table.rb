class DataTable
  def initialize(data)
    @data = data
  end

  def get_element(row, col)
    @data[row][col]
  end

  def row_count
    @data.size
  end

  def column_count
    @data[0].size
  end
end

table = DataTable.new([
                        [1, 2, 4],
                        [1, 2, 3],
                        [4, 5, 6]
                      ])

puts table.get_element(2, 2) # выводит значение элемента на пересечении второй строки и третьего столбца (3)


