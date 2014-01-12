class TopArtistController < UICollectionViewController
  CELL_IDENTIFIER = "cell"
  def viewDidLoad
    super
    @artists = []
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
    @artists.count
  end

  def collectionView(view, cellForItemAtIndexPath:indexPath)
    view.dequeueReusableCellWithReuseIdentifier(CELL_IDENTIFIER, forIndexPath:indexPath).tap do |cell|
      #img = UIImage.alloc.initWithData(NSData.alloc.initWithContentsOfURL(NSURL.URLWithString(@artists[indexPath.row][:image][2]["#text"])))
      #cell.contentView.addSubview(img)
      cell.display_string = @artists[indexPath.row][:name]
    end
  end

  def collectionView(view, didSelectItemAtIndexPath:indexPath)
    Sync.post(@artists[indexPath.row][:name])
  end

  def load_data(data)
    @artists = data[:artists][:artist]
  end

  #"http://userserve-ak.last.fm/serve/34/32862809.jpg"
end