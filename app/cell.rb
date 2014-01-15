class Cell < UICollectionViewCell
  def display_string=(string)
    @display_label.text = string
  end

  def initWithFrame(frame)
    super.tap do |item|
      @display_label = UILabel.alloc.initWithFrame(item.bounds).tap do |label|
         label.backgroundColor = UIColor.whiteColor
         label.textColor = UIColor.blackColor
         label.textAlignment = NSTextAlignmentCenter
         item.addSubview(label)
      end
    end
  end
end