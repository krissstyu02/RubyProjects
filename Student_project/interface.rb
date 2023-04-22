require 'fox16'
include Fox

class Window < FXMainWindow
  def initialize(app)
    super(app, "Students", width: 1100, height: 800) # увеличиваем размер главного окна
    main_frame = FXHorizontalFrame.new(self, LAYOUT_FILL_X | LAYOUT_FILL_Y)

    # Создаем FXTabBook в главном горизонтальном фрейме
    tab_book = FXTabBook.new(main_frame, nil, 0, LAYOUT_FILL_X|LAYOUT_FILL_Y)

    # tab_book = FXTabBook.new(self, nil, 0, LAYOUT_FILL_X|LAYOUT_FILL_Y)
    tab_book.backColor = FXRGB(240, 240, 240) # меняем цвет фона вкладок



    # Create the first tab
    tab1 = FXTabItem.new(tab_book, "Вкладка 1", nil)
    composite1 = FXComposite.new(tab_book, LAYOUT_FILL_X|LAYOUT_FIX_HEIGHT, height: 700,width:1000) # увеличиваем высоту компонента
    # composite1 = FXComposite.new(tab_book, LAYOUT_FILL_X|LAYOUT_FILL_Y)
    @first_tab = FXVerticalFrame.new(composite1)
    @first_tab.resize(1000, 700)
    @count_page = 3
    first_tab

    # Create the second tab
    tab2 = FXTabItem.new(tab_book, "Вкладка 2", nil)
    @composite2 = FXComposite.new(tab_book, LAYOUT_FILL_X|LAYOUT_FILL_Y)

    # Create the third tab
    tab3 = FXTabItem.new(tab_book, "Вкладка 3", nil)
    @composite3 = FXComposite.new(tab_book, LAYOUT_FILL_X|LAYOUT_FILL_Y)

  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  private

  def first_tab
    add_filters
    add_table
  end

  def add_filters
    # Filter
    @frame_filter = FXVerticalFrame.new(@first_tab,:opts => LAYOUT_CENTER_X)
    @frame_filter.resize(1000, 300)

    field_filter = [  [:git, "Гит"],
                      [:email, "Почта"],
                      [:phone, "Телефон"],
                      [:telegram, "Телеграм"]
    ]

    # ФИЛЬТР ИМЕНИ
    name_label = FXLabel.new(@frame_filter, "Фамилия и инициалы")
    name_text_field = FXTextField.new(@frame_filter, 64)
    @filter = { short_name: name_text_field }



    # Фильтрация для остальных полей
    field_filter.each do |field|
      @filter[field[0]] = create_radio_group(field, @frame_filter)

    end

  end



  def add_table
    # Создаем главный вертикальный фрейм для таблицы и элементов управления страницами
    table_frame = FXVerticalFrame.new(@first_tab,:opts => LAYOUT_CENTER_X)
    table_frame.resize(1000, 400)

    # Создаем горизонтальный фрейм для элементов управления страницами
    page_controls = FXHorizontalFrame.new(table_frame, :opts => LAYOUT_CENTER_X)

    # Создаем кнопку "Назад"
    btn_back = FXButton.new(page_controls, "Назад", :opts => BUTTON_NORMAL | LAYOUT_CENTER_Y | LAYOUT_LEFT)
    btn_back.backColor = FXRGB(255, 255, 255)
    btn_back.textColor = FXRGB(0, 0, 0)
    btn_back.font = FXFont.new(app, "Arial", 10, :weight => FONTWEIGHT_BOLD)

    # Создаем метку с номером текущей страницы
    page_label = FXLabel.new(page_controls, "1-#{@count_page}")
    page_label.font = FXFont.new(app, "Arial", 10, :weight => FONTWEIGHT_BOLD)


    # Создаем кнопку "Далее"
    btn_next = FXButton.new(page_controls, "Далее", :opts => BUTTON_NORMAL | LAYOUT_CENTER_Y | LAYOUT_RIGHT)
    btn_next.backColor = FXRGB(255, 255, 255)
    btn_next.textColor = FXRGB(0, 0, 0)
    btn_next.font = FXFont.new(app, "Arial", 10, :weight => FONTWEIGHT_BOLD)


    # Создаем таблицу
    table = FXTable.new(table_frame,
                        :opts => TABLE_READONLY | LAYOUT_FIX_WIDTH | LAYOUT_FIX_HEIGHT | TABLE_COL_SIZABLE | TABLE_ROW_RENUMBER,
                        :width => 700, :height => 300)
    table.setTableSize(10, 3)
    table.backColor = FXRGB(255, 255, 255)
    table.textColor = FXRGB(0, 0, 0)

    # Задаем названия столбцов таблицы
    table.setColumnText(0, "ФИО")
    table.setColumnText(1, "Git")
    table.setColumnText(2, "Контакт")

    # Заполняем таблицу данными
    data = [
      ["Apple", "@apple", "apple@example.com"],
      ["Nanana", "@banana", "banana@example.com"],
      ["Cherry", "@cherry", "cherry@example.com"],
      ["Durian", "@durian", "durian@example.com"],
      ["Elderberry", "@elderberry", "elderberry@example.com"],
      ["Gig", "@fig", "fig@example.com"],
      ["Grape", "@grape", "grape@example.com"],
      ["Honeydew", "@honeydew", "honeydew@example.com"],
      ["Rackfruit", "@jackfruit", "jackfruit@example.com"],
      ["Kiwi", "@kiwi", "kiwi@example.com"]
    ]
    data.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        table.setItemText(i, j, cell)
      end
    end
    # 700 300
    # Масштабируем таблицу
    table.setRowHeaderWidth(50)
    table.setColumnWidth(0, 200)
    table.setColumnWidth(1, 200)
    table.setColumnWidth(2, 248)

    # Создаем обработчик событий для сортировки таблицы по столбцу при нажатии на заголовок столбца
    table.getColumnHeader.connect(SEL_COMMAND) do |a, b, col|
      sort_table_by_column(table, col)
    end

    # Создаем обработчик событий для сброса выделения при переключении страниц
    page_controls.connect(SEL_COMMAND) do
      table.killSelection
    end

    page_controls = FXHorizontalFrame.new(table_frame, :opts => LAYOUT_CENTER_X)

    # Создаем кнопку "Добавить"
    btn_add = FXButton.new(page_controls, "Добавить", :opts => BUTTON_NORMAL | LAYOUT_CENTER_Y)
    btn_add.backColor = FXRGB(255, 255, 255)
    btn_add.textColor = FXRGB(0, 0, 0)
    btn_add.font = FXFont.new(app, "Arial", 10, :weight => FONTWEIGHT_BOLD)

    # Создаем кнопку "Изменить"
    btn_edit = FXButton.new(page_controls, "Изменить", :opts => BUTTON_NORMAL | LAYOUT_CENTER_Y)
    btn_edit.backColor = FXRGB(255, 255, 255)
    btn_edit.textColor = FXRGB(0, 0, 0)
    btn_edit.font = FXFont.new(app, "Arial", 10, :weight => FONTWEIGHT_BOLD)

    # Создаем кнопку "Удалить"
    btn_delete = FXButton.new(page_controls, "Удалить", :opts => BUTTON_NORMAL | LAYOUT_CENTER_Y)
    btn_delete.backColor = FXRGB(255, 255, 255)
    btn_delete.textColor = FXRGB(0, 0, 0)
    btn_delete.font = FXFont.new(app, "Arial", 10, :weight => FONTWEIGHT_BOLD)

    # Создаем кнопку "Обновить"
    btn_refresh = FXButton.new(page_controls, "Обновить", :opts => BUTTON_NORMAL | LAYOUT_CENTER_Y)
    btn_refresh.backColor = FXRGB(255, 255, 255)
    btn_refresh.textColor = FXRGB(0, 0, 0)
    btn_refresh.font = FXFont.new(app, "Arial", 10, :weight => FONTWEIGHT_BOLD)

    # Делаем кнопки изменить и удалить неактивными по умолчанию
    btn_edit.disable
    btn_delete.disable


    table.connect(SEL_CHANGED) do
      num_selected_rows = 0
      (0...table.getNumRows()).each { |row_index| num_selected_rows+=1 if table.rowSelected?(row_index)}

      # Если выделена только одна строка, кнопка должна быть неактивной
      if num_selected_rows == 1
        btn_edit.enable
        btn_delete.enable
        # Если выделено несколько строк, кнопка должна быть активной
      elsif num_selected_rows >1
        btn_edit.disable
        btn_delete.enable
      end
    end

  end

  #сортировка таблицы по столбцу
  def sort_table_by_column(table, column_index)

    #ере
    table_data = (0...table.getNumRows()).map { |row_index| (0...table.getNumColumns()).map { |col_index| table.getItemText(row_index, col_index) } }

    sorted_table_data = table_data.sort_by { |row_data| row_data[column_index] }
    sorted_table_data.each_with_index do |row_data, row_index|
      row_data.each_with_index do |cell_data, col_index|
        table.setItemText(row_index, col_index, cell_data)
      end
    end
  end
  def create_radio_group(field, parent)
    #Фильтрация гита
    frame_field = FXVerticalFrame.new(parent, LAYOUT_FILL_X||LAYOUT_SIDE_TOP)
    label_field = FXLabel.new(frame_field, field[1])
    line_radio = FXHorizontalFrame.new(frame_field, LAYOUT_FILL_X|LAYOUT_SIDE_TOP)
    # Создаем radiobutton
    radio_yes = FXRadioButton.new(line_radio, "Да")
    radio_no = FXRadioButton.new(line_radio, "Нет")
    radio_no_matter = FXRadioButton.new(line_radio, "Не важно")
    #фильтр
    text_field = FXTextField.new(line_radio, 40)
    #прописываем доступность
    text_field.setEnabled(false)
    radio_yes.connect(SEL_COMMAND) do
      radio_no.check=false
      radio_no_matter.check=false
      if radio_yes.checked?
        text_field.setEnabled(true)
      end
    end
    radio_no.connect(SEL_COMMAND) do
      radio_no_matter.check=false
      radio_yes.check=false
      if radio_no.checked?
        text_field.setEnabled(false)
      end
    end
    radio_no_matter.connect(SEL_COMMAND) do
      radio_no.check=false
      radio_yes.check=false
      if radio_no_matter.checked?
        text_field.setEnabled(false)
      end
    end
    frame_field
  end
end
app = FXApp.new
Window.new(app)
app.create
app.run