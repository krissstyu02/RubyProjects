# frozen_string_literal: true
require 'fox16'

include Fox
class CreateLabDialog<FXDialogBox
  def initialize(parent, controller)
    super(parent, "Лабораторная работа", DECOR_TITLE | DECOR_BORDER | DECOR_RESIZE)
    @controller = controller
    @lab = nil
    setWidth(450)
    setHeight(160)
    add_fields
  end

  def set_lab(lab=nil)
    @lab=lab
    enter_lab
  end

  def add_fields
    frame_data = FXVerticalFrame.new(self, :opts=> LAYOUT_FILL_X|LAYOUT_FILL_Y )
    @field_text = {}

    field_name = [[:number, "Номер лабораторной"], [:name, 'Название'], [:date_load, 'Дата']]
    field_name.each do |field|
      frame_field = FXHorizontalFrame.new(frame_data)
      field_label = FXLabel.new(frame_field, field[1], :opts => LAYOUT_FIX_WIDTH)
      field_label.setWidth(150)
      text = FXTextField.new(frame_field, 40, :opts=>TEXTFIELD_NORMAL)
      @field_text[field[0]] = text
    end

    @field_text[:number].editable = false
    btn_frame = FXHorizontalFrame.new(frame_data, LAYOUT_CENTER_X)
    btn_add=FXButton.new(btn_frame, "Сохранить")
    btn_add.textColor = Fox.FXRGB(0,23,175)
    btn_add.disable

    btn_back=FXButton.new(btn_frame, "Отмена")
    btn_back.textColor = Fox.FXRGB(0,23,175)

    btn_add.connect(SEL_COMMAND) do
      @controller.save_lab(@lab)
      self.handle(btn_add, FXSEL(Fox::SEL_COMMAND,
                                 Fox::FXDialogBox::ID_ACCEPT), nil)
    end

    btn_back.connect(SEL_COMMAND) do
      self.handle(btn_back, FXSEL(Fox::SEL_COMMAND,
                                  Fox::FXDialogBox::ID_CANCEL), nil)
    end

    @field_text.each_key do |name_field|
      @field_text[name_field].connect(SEL_CHANGED) do |text_field|
        res = {}
        @field_text.each do |k,v|
          text = v.text.empty? ? nil : v.text
          res[k] = text
        end

        result = @controller.validate_fields(res)
        unless result.nil?
          @lab = result
          btn_add.enable
        else
          btn_add.disable
        end
      end
    end
  end

  def enter_lab
    unless @lab.nil?
      nil
    else
      @field_text[:number].text = @controller.next_number_lab.to_s
    end

  end
end
