# frozen_string_literal: true
require 'fox16'

include Fox
class CreateStudentDialog<FXDialogBox
  def initialize(parent, controller)
    # Создаем родительское модальное окно
    super(parent, "Добавление студента", DECOR_TITLE | DECOR_BORDER | DECOR_RESIZE)

    @controller = controller
    @student = nil

    # Устанавливаем размер окна и делаем его модальным
    setWidth(500)
    setHeight(400)
    add_fields
    # setModal(true)
  end

  def set_student(student,editable_fields)
    @student=student
    enter_student(editable_fields)
  end

  private

  def add_fields
    #кнопка отмены

    frame_data = FXVerticalFrame.new(self, :opts=> LAYOUT_FILL_X|LAYOUT_FILL_Y )

    field_name =[[:first_name,'Имя'], [:last_name, 'Фамилия'], [:paternal_name, 'Отчество'], [:git, 'Гит'], [:email, 'Почта'], [:phone, 'Телефон'], [:telegram, 'Телеграм']]
    @field_text = {}
    field_name.each do |field|
      frame_field = FXHorizontalFrame.new(frame_data )
      field_label = FXLabel.new(frame_field, field[1], :opts => LAYOUT_FIX_WIDTH)
      field_label.setWidth(100)
      text = FXTextField.new(frame_field, 40, :opts=>TEXTFIELD_NORMAL)
      @field_text[field[0]] = text

    end

    btn_frame = FXHorizontalFrame.new(frame_data, LAYOUT_CENTER_X)
    btn_add=FXButton.new(btn_frame, "Сохранить")
    btn_add.textColor = Fox.FXRGB(0,23,175)
    btn_add.disable

    btn_back=FXButton.new(btn_frame, "Отмена")
    btn_back.textColor = Fox.FXRGB(0,23,175)

    btn_add.connect(SEL_COMMAND) do
      @controller.save_student(@student)
      self.handle(btn_add, FXSEL(Fox::SEL_COMMAND,
                                 Fox::FXDialogBox::ID_ACCEPT), nil)
      # @controller.on_add_click(@student)
    end

    btn_back.connect(SEL_COMMAND) do
      self.handle(btn_back, FXSEL(Fox::SEL_COMMAND,
                                  Fox::FXDialogBox::ID_CANCEL), nil)
      # @controller.on_add_click(@student)
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
          @student = result
          btn_add.enable
        else
          btn_add.disable
        end

      end
    end

  end

  def enter_student(editable_fields)
    unless @student.nil?
      student_hash = @student.to_hash
      @field_text.each_key do |name_field|
          puts "fields #{name_field}"
          unless editable_fields.include?(name_field)
          @field_text[name_field].editable = false
          end
          @field_text[name_field].text = student_hash[name_field]
          puts(student_hash[name_field])

      end
    end
  end


end
