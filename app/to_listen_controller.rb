class ToListenController < UITableViewController
  def viewDidLoad
    super
    setupNavigationBar
    @artists = []
  end

  def load_data(data)
    @artists = data
  end

  def setupNavigationBar
    self.title = "To-Listen"
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    left_button_item = UIBarButtonItem.alloc.initWithImage(UIImage.imageNamed("icon-cogs.png"), style: UIBarButtonItemStyleBordered, target:self, action:"popActionSheet")
    self.navigationItem.setLeftBarButtonItem(left_button_item)
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "MenuCell"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) ||      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: @reuseIdentifier)
    cell.setSelectionStyle UITableViewCellSelectionStyleGray

    attributed_text = NSMutableAttributedString.alloc.initWithString(@artists[indexPath.row]['name'])
    if @artists[indexPath.row]['listened'] == true
      #attributed_text.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: [0, attributed_text.length])
      cell.textLabel.textColor = UIColor.grayColor
    else
      cell.textLabel.textColor = UIColor.blackColor
      #attributed_text.removeAttribute(NSStrikethroughStyleAttributeName, range: [0, attributed_text.length])
    end
    cell.textLabel.attributedText = attributed_text

    cell
  end
  #
  def tableView(tableView, numberOfSectionsInTableView: sections)
    1
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @artists.count
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated:true)

    Sync.put(@artists[indexPath.row]) && Sync.get(self)
  end

  def tableView(tableView, commitEditingStyle:editingStyle, forRowAtIndexPath:indexPath)
    if editingStyle == UITableViewCellEditingStyleDelete

      Sync.delete(@artists[indexPath.row])
      @artists.delete_at(indexPath.row)
      view.deleteRowsAtIndexPaths([indexPath],withRowAnimation:UITableViewRowAnimationMiddle)
      tableView.endUpdates
      #tableView.reloadData
      Sync.get(self)
      #view.deleteSectionsAtIndexPaths(sections ,withRowAnimation:UITableViewRowAnimationFade)
    end
  end

  def popActionSheet
    p "AS"
    UIActionSheet.alloc.initWithTitle("Options",
    delegate: self,
    cancelButtonTitle: "Cancel",
    destructiveButtonTitle: nil,
    otherButtonTitles: "Delete all listened", nil).showInView(view)
  end

  def actionSheet(view, clickedButtonAtIndex:buttonIndex)
    p @artists
    @artists.count.times do |i|
      if @artists[i]['listened'] == true
        p "listened true"
        p i
        #@artists.delete_at(i)
        Sync.delete(@artists[i])
      else
        p "listened false"
      end
    end
    Sync.get(self)
  end
end
