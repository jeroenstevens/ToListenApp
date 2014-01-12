class TopArtistController < UICollectionViewController
  CELL_IDENTIFIER = "cell"
  def viewDidLoad
    super
    @artist = []
    @setup = Setup.new
    @setup.navigationBar(delegate)
    @setup.collectionView(delegate)
    Fetch.top_artists(delegate)
    setupTabBar
  end

  def setupTabBar
    self.title = "Top Artists"
    self.tabBarItem = UITabBarItem.alloc.initWithTabBarSystemItem(UITabBarSystemItemFeatured, tag: 1)
    @to_listen = UINavigationController.alloc.initWithRootViewController(ToListenController.alloc.initWithStyle(UITableViewStylePlain))
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

  def load_data(data)
    @artist = data[:artists][:artist]
  end

  #"http://userserve-ak.last.fm/serve/34/32862809.jpg"

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