class SimilarArtistController < UICollectionViewController
  CELL_IDENTIFIER = "cell"
  def viewDidLoad
    super
    @artist = []
    view.backgroundColor = UIColor.scrollViewTexturedBackgroundColor
    this = self
    setupTabBar
    @setup = Setup.new
    @setup.navigationBar(this)
    @setup.collectionView(this)
    #view.dataSource = view.delegate = self
    #setupSearchBar
  end

  def setupNavigationBar
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    right_button_item = UIBarButtonItem.alloc.initWithTitle('Add', style: UIBarButtonItemStyleBordered,target: self, action: "popActionSheet")
    self.navigationItem.setRightBarButtonItem(right_button_item)
  end

  def setupTabBar
    self.title = "artistName"
    self.tabBarItem = UITabBarItem.alloc.initWithTabBarSystemItem(UITabBarSystemItemSearch, tag: 1)
  end

  def setupSearchBar
    searchBar = UISearchBar.alloc.initWithFrame(CGRectMake(0, 0, 20, 0),delegate: self,showsCancelButton: true,sizeToFit: true)
    self.navigationItem.titleView = searchBar

    searchBar.text = 'Caliban'

    searchBarSearchButtonClicked(searchBar)
  end

  def searchBarSearchButtonClicked(searchBar)
    p "searchbar clicked"

    searchBar.resignFirstResponder
  end

  def getSimilarArtists
    lastfm_api_endpoint = "http://ws.audioscrobbler.com/2.0/?api_key=f90b2e1d432ddfeee9b30524aeedd6d7&format=json"
    method = "artist.getsimilar"
    query = searchBar.text.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
    url = lastfm_api_endpoint + "&method=" + method + "&artist=" + query

    BW::HTTP.get(url) do |response|
      @data = BW::JSON.parse(response.body.to_s)
      artist()
    end
  end

  def artist()
    @artist.clear
    @artist = @data[:similarartists][:artist]
    collectionView.reloadData
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

  def popActionSheet
    p "here"
    UIActionSheet.alloc.initWithTitle("Options",
    delegate: self,
    cancelButtonTitle: "Cancel",
    destructiveButtonTitle: nil,
    otherButtonTitles: "Test 1", "Test 2", nil).showInView(view)
  end

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
end