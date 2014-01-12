class ToListenController < UITableViewController
  def viewDidLoad
    super
    setupNavigationBar
    @artists = []
    p self
    Sync.get(self)
    #@sync.result.each { |i| @artists << i['name'] }
    tableView.rowHeight = 50
  end

  def load_data(data)
    @artists = data
    tableView.reloadData
  end

  def setupNavigationBar
    self.title = "To-Listen"
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    left_button_item = UIBarButtonItem.alloc.initWithImage(UIImage.imageNamed("icon-cogs.png"), style: UIBarButtonItemStyleBordered, target:self, action:"popActionSheet")
    self.navigationItem.setLeftBarButtonItem(left_button_item)
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "MenuCell"

    label = UILabel.alloc.initWithFrame [[10, 10], [150, 30]]

    #Strikethrough
    if @artists[indexPath.row]['listened'] == true
      attributed_text = NSMutableAttributedString.alloc.initWithString(@artists[indexPath.row]['name'])
      attributed_text.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: [0, attributed_text.length])
      label.attributedText = attributed_text
    else
      label.attributedText = nil
      # label.text = @artists[indexPath.row]['name']
      label.text = "strike"
    end

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) ||
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: @reuseIdentifier)
    cell.setSelectionStyle UITableViewCellSelectionStyleGray
    cell.accessoryType = UITableViewCellAccessoryCheckmark
    cell.contentView.addSubview label
    cell
  end

  def tableView(tableView, numberOfSectionsInTableView: sections)
    1
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @artists.count
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    p "to_listen_item_tapped"
    #tableView.deselectRowAtIndexPath(indexPath, animated:true)
    p view
    p @artists[indexPath.row][:name]
    Sync.put(@artists[indexPath.row])

    view.when_swiped do
      p "do if swiped from right to left"

    end.direction = UISwipeGestureRecognizerDirectionLeft

    view.when_swiped do
      p "do if swiped from left to right"
    end.direction = UISwipeGestureRecognizerDirectionRight
  end

  def popActionSheet
    p "AS"
    UIActionSheet.alloc.initWithTitle("Options",
    delegate: self,
    cancelButtonTitle: "Cancel",
    destructiveButtonTitle: nil,
    otherButtonTitles: "Test 1", "Test 2", nil).showInView(view)
  end

  def actionSheet(view, clickedButtonAtIndex:buttonIndex)
    Sync.delete(@artists[0])
  end
end
