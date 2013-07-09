class RootViewController < UIViewController
  def viewDidLoad
    view.backgroundColor = UIColor.scrollViewTexturedBackgroundColor

    @text_field = name_text_field
    @remote_time_label = remote_time_label

    view.addSubview name_label
    view.addSubview @text_field
    view.addSubview @remote_time_label

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
    label = UILabel.alloc.initWithFrame [[0, 350], [view.frame.size.width, 30]]
    label.backgroundColor = UIColor.clearColor
    label.textColor = UIColor.whiteColor
    label.textAlignment = NSTextAlignmentCenter

    label
  end
end
