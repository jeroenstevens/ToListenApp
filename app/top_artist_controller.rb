class TopArtistController < UICollectionViewController
  CELL_IDENTIFIER = "cell"
  def viewDidLoad
    super
    @artist = []
    this = self
    @setup = Setup.new
    @setup.navigationBar(this)
    @setup.collectionView(this)
    fetch_top_artists
    setupTabBar
  end

  def setupNavigationBar
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    left_button_item = UIBarButtonItem.alloc.initWithImage(UIImage.imageNamed("icon-menu.png"), style: UIBarButtonItemStyleBordered, target:self, action: 'toggleMenuState')
    self.navigationItem.setLeftBarButtonItem(left_button_item)

    right_button_item = UIBarButtonItem.alloc.initWithTitle('Add', style:UIBarButtonItemStyleBordered,target: self, action: "click_add")
    self.navigationItem.setRightBarButtonItem(right_button_item)
  end

  def setupCollectionView
    self.collectionView.registerClass(Cell, forCellWithReuseIdentifier:CELL_IDENTIFIER)
    #self.collectionView.collectionViewLayout.headerReferenceSize = CGSizeMake(HEADER_WIDTH, HEADER_HEIGHT)
    self.collectionView.collectionViewLayout.itemSize = CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT)
    self.collectionView.collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0)
    self.collectionView.backgroundColor = UIColor.scrollViewTexturedBackgroundColor
  end

  def setupTabBar
    self.title = "Top Artists"
    self.tabBarItem = UITabBarItem.alloc.initWithTabBarSystemItem(UITabBarSystemItemFeatured, tag: 1)
  end

  def numberOfSectionsInCollectionView(view)
    1
  end

  def collectionView(view, numberOfItemsInSection:section)
    @artist.count
  end

  def collectionView(view, cellForItemAtIndexPath:indexPath)
    view.dequeueReusableCellWithReuseIdentifier(CELL_IDENTIFIER, forIndexPath:indexPath).tap do |cell|
      #img = UIImage.alloc.initWithData(NSData.alloc.initWithContentsOfURL(NSURL.URLWithString(@artist[indexPath.row][:image][2]["#text"])))
      #cell.contentView.addSubview(img)
      cell.display_string = @artist[indexPath.row][:name]
    end
  end

  def fetch_top_artists
    lastfm_api_endpoint = "http://ws.audioscrobbler.com/2.0/?api_key=f90b2e1d432ddfeee9b30524aeedd6d7&format=json"
    method = "chart.gettopartists"
    url = lastfm_api_endpoint + "&method=" + method

    BW::HTTP.get(url) do |response|
      @data = BW::JSON.parse(response.body.to_s)
      artist()
    end
  end

  def artist()
    @artist = @data[:artists][:artist]
    collectionView.reloadData
  end

  #"http://userserve-ak.last.fm/serve/34/32862809.jpg"

  def toggleMenuState
    destination = navigationController.view.frame
    if destination.origin.x > 0
      destination.origin.x = 0
      @visible = false
    else
      destination.origin.x += 254.5
      @visible = true
    end

    UIView.animateWithDuration 0.5, animations: -> {
      navigationController.view.frame = destination
    }
    to_listen = UINavigationController.alloc.initWithRootViewController(ToListenController.alloc.initWithStyle(UITableViewStylePlain))
    navigationController.visibleViewController.view.userInteractionEnabled = !(destination.origin.x > 0)

    navigationController.view.superview.insertSubview to_listen.view, belowSubview: navigationController.view
  end

  def artist_view(count)
    @blue_view = UIView.alloc.initWithFrame(CGRect.new([150,100  + count * 10], [100,100]))
    @blue_view.backgroundColor = UIColor.redColor
    @window.addSubview(@blue_view)

    @add_button = UIButton.buttonWithType(UIButtonTypeCustom)
    @add_button.setTitle("artistName - #{count}", forState:UIControlStateNormal)
    @add_button.sizeToFit
    @add_button.frame = CGRect.new(
    [10 + count * 100, 100], [75,75])
    @add_button.backgroundColor = UIColor.blueColor
    @window.addSubview(@add_button)

    @add_button.addTarget(
      self, action:"add_artist", forControlEvents:UIControlEventTouchUpInside
    )
  end

  def add_artist
    @count = @count + 1
    p @count
    p artist_view(@count)
    artist_view(@count)
  end
end