class RootViewController < UIViewController
  def viewDidLoad
    view.backgroundColor = UIColor.scrollViewTexturedBackgroundColor

    @text_field = name_text_field
    @text_field.delegate = self

    view.addSubview name_label
    view.addSubview @text_field
  end

  def textFieldShouldReturn(textField)
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

    textField
  end
end
