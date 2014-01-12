class Setup
  CELL_IDENTIFIER = 'cell'
  ITEM_WIDTH = 155
  ITEM_HEIGHT = 155
  HEADER_WIDTH = 10
  HEADER_HEIGHT = 30

  def navigationBar(delegate)
    delegate.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    left_button_item = UIBarButtonItem.alloc.initWithImage(UIImage.imageNamed("icon-menu.png"), style: UIBarButtonItemStyleBordered, target: self, action:'toggleMenuState')
    delegate.navigationItem.setLeftBarButtonItem(left_button_item)

    right_button_item = UIBarButtonItem.alloc.initWithTitle('Add', style:UIBarButtonItemStyleBordered,target: delegate, action: "click_add")
    delegate.navigationItem.setRightBarButtonItem(right_button_item)

    @to_listen = UINavigationController.alloc.initWithRootViewController(ToListenController.alloc.initWithStyle(UITableViewStylePlain))
    @delegate = delegate
  end

  def collectionView(delegate)
    delegate.collectionView.registerClass(Cell, forCellWithReuseIdentifier:CELL_IDENTIFIER)
    #self.collectionView.collectionViewLayout.headerReferenceSize = CGSizeMake(HEADER_WIDTH, HEADER_HEIGHT)
    delegate.collectionView.collectionViewLayout.itemSize = CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT)
    delegate.collectionView.collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0)
    delegate.collectionView.backgroundColor = UIColor.scrollViewTexturedBackgroundColor
  end

  def toggleMenuState
    destination = @delegate.navigationController.view.frame
    if destination.origin.x > 0
      destination.origin.x = 0
      @visible = false
    else
      destination.origin.x += 254.5
      @visible = true
    end

    Sync.get(@to_listen.visibleViewController)

    UIView.animateWithDuration 0.5, animations: -> {
      @delegate.navigationController.view.frame = destination
    }

    @delegate.navigationController.visibleViewController.view.userInteractionEnabled = !(destination.origin.x > 0)

    @delegate.navigationController.view.superview.insertSubview @to_listen.view, belowSubview: @delegate.navigationController.view
  end
end