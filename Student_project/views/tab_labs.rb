# frozen_string_literal: true
require 'fox16'
include Fox
require_relative '../controller/lab_controller'
require_relative 'tab_students'

class TabLab<FXVerticalFrame
  def initialize(parent, *args, &blk)
    super
    @controller = StudentLabController.new(self)
    add_table
  end

  def add_table
    table_frame = FXVerticalFrame.new(self, :padLeft=>20)
    # page_change_buttons(table_frame)
    # Создаем таблицу
    @table = FXTable.new(table_frame, :opts =>  TABLE_READONLY|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT|TABLE_COL_SIZABLE|TABLE_ROW_RENUMBER, :width=>600, :height=>320)
    @table.setTableSize(16, 3)

    @table.setColumnText(0, "Номер")
    @table.setColumnText(1, "Наименование")
    @table.setColumnText(2, "Дата выдачи")

    # Масштабируем таблицу
    @table.setRowHeaderWidth(30)
    @table.setColumnWidth(1, 300)
    @table.setColumnWidth(2, 150)

    @table.getColumnHeader.connect(SEL_COMMAND) do |a, b, col|
      sort_table_by_column(@table, col)
      end

    page_controls2 = FXHorizontalFrame.new(table_frame, :opts => LAYOUT_CENTER_X)
    # Создаем кнопку "Добавить"
    btn_add = FXButton.new(page_controls2, "Добавить", :opts => BUTTON_NORMAL | LAYOUT_CENTER_Y)
    btn_add.backColor = FXRGB(255, 255, 255)
    btn_add.textColor = FXRGB(0, 0, 0)
    btn_add.font = FXFont.new(app, "Arial", 10, :weight => FONTWEIGHT_BOLD)


    # Создаем кнопку "Удалить"
    btn_delete = FXButton.new(page_controls2, "Удалить", :opts => BUTTON_NORMAL | LAYOUT_CENTER_Y)
    btn_delete.backColor = FXRGB(255, 255, 255)
    btn_delete.textColor = FXRGB(0, 0, 0)
    btn_delete.font = FXFont.new(app, "Arial", 10, :weight => FONTWEIGHT_BOLD)


    # Создаем кнопку "Обновить"
    btn_refresh = FXButton.new(page_controls2, "Обновить", :opts => BUTTON_NORMAL | LAYOUT_CENTER_Y)
    btn_refresh.backColor = FXRGB(255, 255, 255)
    btn_refresh.textColor = FXRGB(0, 0, 0)
    btn_refresh.font = FXFont.new(app, "Arial", 10, :weight => FONTWEIGHT_BOLD)


    # Создаем кнопку "Изменить"
    btn_remove = FXButton.new(page_controls2, "Изменить", :opts => BUTTON_NORMAL | LAYOUT_CENTER_Y)
    btn_remove.backColor = FXRGB(255, 255, 255)
    btn_remove.textColor = FXRGB(0, 0, 0)
    btn_remove.font = FXFont.new(app, "Arial", 10, :weight => FONTWEIGHT_BOLD)


    btn_delete.disable
    btn_remove.disable

    @table.connect(SEL_CHANGED) do
      num_selected_rows = 0
      (0...@table.getNumRows()).each { |row_index| num_selected_rows+=1 if @table.rowSelected?(row_index)}

      # Если выделена только одна строка, кнопка должна быть неактивной
      if num_selected_rows == 1
        btn_remove.enable
        btn_delete.enable
        # Если выделено несколько строк, кнопка должна быть активной
      elsif num_selected_rows >1
        btn_remove.disable
        btn_delete.enable
      end
    end

    @table.getRowHeader.connect(SEL_RIGHTBUTTONPRESS) do
      @table.killSelection(true)
      btn_remove.disable
      btn_delete.disable
    end

    btn_refresh.connect(SEL_COMMAND) do
      refresh
    end

  end

  def refresh
    @controller.refresh_data
  end


  def on_datalist_changed(table)
    TabStudent.update_data_table(@table, table)
  end

  end

