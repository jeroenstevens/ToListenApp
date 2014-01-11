class ToListenController < UITableViewController
  def init
    self.tableView.dataSource = self.tableView.delegate = self
  end
  def viewDidLoad
    super
    setupNavigationBar
    @labels = []
    @sync = Sync.new
    @sync.get
    @sync.result.each {|i| @labels << i['name']}
    tableView.rowHeight = 50
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
    label.text = @labels[indexPath.row]

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) ||
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: @reuseIdentifier)
    cell.setSelectionStyle UITableViewCellSelectionStyleGray
    cell.contentView.addSubview label
    cell
  end

  def tableView(tableView, numberOfSectionsInTableView: sections)
    1
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @labels.count
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    p "to_listen_item_tapped"
  end

  def popActionSheet
    p "AS"
    UIActionSheet.alloc.initWithTitle("Options",
    delegate: self,
    cancelButtonTitle: "Cancel",
    destructiveButtonTitle: nil,
    otherButtonTitles: "Test 1", "Test 2", nil).showInView(view)
  end
end
