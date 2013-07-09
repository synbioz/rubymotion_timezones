class RootViewController < UIViewController
  def viewDidLoad
    view.backgroundColor = UIColor.scrollViewTexturedBackgroundColor

    @text_field = name_text_field
    @remote_time_label = remote_time_label

    @timezones = NSTimeZone.knownTimeZoneNames
    @date_picker = date_picker

    view.addSubview name_label
    view.addSubview @text_field
    view.addSubview @remote_time_label
    view.addSubview timezone_picker
    view.addSubview @date_picker

    single_tap = UITapGestureRecognizer.alloc.initWithTarget(self, action: :'handle_single_tap')
    view.addGestureRecognizer(single_tap)

    @date_picker.addTarget(self, action: :'handle_date_change', forControlEvents:UIControlEventValueChanged)
  end

  def textFieldShouldReturn(text_field)
    text_field.resignFirstResponder
    @remote_time_label.text = "Bonjour #{text_field.text} !"
  end

  def handle_single_tap
    @text_field.resignFirstResponder
  end

  def handle_date_change
    fr_FR = NSLocale.alloc.initWithLocaleIdentifier "fr_FR"

    format = NSDateFormatter.alloc.init
    format.locale = fr_FR
    format.setDateFormat("dd MMM yyyy - HH:mm")

    # Conversion de la date en chaine
    dateString = format.stringFromDate(@date_picker.date)

    @remote_time_label.text = dateString
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
    label = UILabel.alloc.initWithFrame [[0, 430], [view.frame.size.width, 30]]
    label.backgroundColor = UIColor.clearColor
    label.textColor = UIColor.whiteColor
    label.textAlignment = NSTextAlignmentCenter

    label
  end

  def timezone_picker
    picker = UIPickerView.alloc.initWithFrame [[0, 50], [320, 120]]
    picker.showsSelectionIndicator = true
    picker.dataSource = self
    picker.delegate = self

    picker
  end

  def date_picker
    picker = UIDatePicker.alloc.init
    picker.center = [view.frame.size.width / 2, 320]

    picker
  end
end
