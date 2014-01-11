class Setup
  CELL_IDENTIFIER = 'cell'
  ITEM_WIDTH = 155
  ITEM_HEIGHT = 155
  HEADER_WIDTH = 10
  HEADER_HEIGHT = 30

  def navigationBar(this)
    this.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    left_button_item = UIBarButtonItem.alloc.initWithImage(UIImage.imageNamed("icon-menu.png"), style: UIBarButtonItemStyleBordered, target:this, action:"toggleMenuState")
    this.navigationItem.setLeftBarButtonItem(left_button_item)

    right_button_item = UIBarButtonItem.alloc.initWithTitle('Add', style:UIBarButtonItemStyleBordered,target: this, action: "click_add")
    this.navigationItem.setRightBarButtonItem(right_button_item)
  end

  def collectionView(this)
    this.collectionView.registerClass(Cell, forCellWithReuseIdentifier:CELL_IDENTIFIER)
    #self.collectionView.collectionViewLayout.headerReferenceSize = CGSizeMake(HEADER_WIDTH, HEADER_HEIGHT)
    this.collectionView.collectionViewLayout.itemSize = CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT)
    this.collectionView.collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0)
    this.collectionView.backgroundColor = UIColor.scrollViewTexturedBackgroundColor
  end
end