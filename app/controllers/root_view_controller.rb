class RootViewController < UIViewController
  def viewDidLoad
    view.backgroundColor = UIColor.scrollViewTexturedBackgroundColor

    @text_field = name_text_field
    @remote_time_label = remote_time_label

    @timezones = NSTimeZone.knownTimeZoneNames

    view.addSubview name_label
    view.addSubview @text_field
    view.addSubview @remote_time_label
    view.addSubview timezone_picker

    single_tap = UITapGestureRecognizer.alloc.initWithTarget(self, action: :'handle_single_tap')
    view.addGestureRecognizer(single_tap)
  end

  def textFieldShouldReturn(text_field)
    text_field.resignFirstResponder
    @remote_time_label.text = "Bonjour #{text_field.text} !"
  end

  def handle_single_tap
    @text_field.resignFirstResponder
  end

  def numberOfComponentsInPickerView(pickerView)
    1
  end

  def pickerView(pickerView, numberOfRowsInComponent:component)
    @timezones.size
  end

  def pickerView(pickerView, titleForRow:row, forComponent:component)
    @timezones[row]
  end

  def pickerView(pickerView, didSelectRow:row, inComponent:component)
    @remote_time_label.text = "#{@text_field.text}, vous avez choisi #{@timezones[row]}"
  end


  private

  def name_label
    label = UILabel.alloc.initWithFrame [[10, 10], [100, 30]]
    label.backgroundColor = UIColor.clearColor
    label.textColor = UIColor.whiteColor
    label.text = "Votre nom"

    label
  end

  def name_text_field
    textField = UITextField.alloc.initWithFrame [[110, 10], [170, 30]]
    textField.borderStyle = UITextBorderStyleRoundedRect
    textField.font = UIFont.systemFontOfSize(15)
    textField.delegate = self

    textField
  end

  def remote_time_label
    label = UILabel.alloc.initWithFrame [[0, 400], [view.frame.size.width, 30]]
    label.backgroundColor = UIColor.clearColor
    label.textColor = UIColor.whiteColor
    label.textAlignment = NSTextAlignmentCenter

    label
  end

  def timezone_picker
    picker = UIPickerView.alloc.init
    picker.showsSelectionIndicator = true
    picker.center = self.view.center
    picker.dataSource = self
    picker.delegate = self

    picker
  end
end
