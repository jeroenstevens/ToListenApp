class Cell < UICollectionViewCell
  def display_string=(string)
    @display_label.text = string
  end

  def initWithFrame(frame)
    super.tap do |header|
      @display_label = UILabel.alloc.initWithFrame(header.bounds).tap do |label|
         label.backgroundColor = UIColor.whiteColor
         label.textColor = UIColor.blackColor
         label.textAlignment = NSTextAlignmentCenter
         header.addSubview(label)
      end
    end
  end

  # #Strikethrough
  # attributed_text = NSMutableAttributedString.alloc.initWithString("Atributed Text")
  # attributed_text.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: [0, attributed_text.length])
  # label.attributedText = attributed_text
end