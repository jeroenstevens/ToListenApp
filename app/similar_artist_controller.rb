class SimilarArtistController < UICollectionViewController
  CELL_IDENTIFIER = "cell"
  def viewDidLoad
    super
    @artist = []
    @artists = []
    @setup = Setup.new
    @setup.navigationBar(delegate)
    @setup.collectionView(delegate)
    setupSearchBar
    setupTabBar
  end

  def setupTabBar
    self.tabBarItem = UITabBarItem.alloc.initWithTabBarSystemItem(UITabBarSystemItemSearch, tag: 1)
  end

  def setupSearchBar
    searchBar = UISearchBar.alloc.initWithFrame(CGRectMake(0, 0, 20, 0),delegate: self,showsCancelButton: true,sizeToFit: true)
    self.navigationItem.titleView = searchBar

    searchBar.text = 'flash-sparks'

    searchBarSearchButtonClicked(searchBar)
  end

  def searchBarSearchButtonClicked(searchBar)
    p "searchbar clicked"

    searchBar.resignFirstResponder

    Fetch.random_artist_by_user_name(delegate, searchBar.text)
  end

  def load_data(data)
    @artist = data[:artists][:artist]
  end

  def numberOfSectionsInCollectionView(view)
    1
  end

  def collectionView(view, numberOfItemsInSection:section)
    @artists.count
  end

  def collectionView(view, cellForItemAtIndexPath:indexPath)
    view.dequeueReusableCellWithReuseIdentifier(CELL_IDENTIFIER, forIndexPath:indexPath).tap do |cell|
      #img = UIImage.alloc.initWithData(NSData.alloc.initWithContentsOfURL(NSURL.URLWithString(@artist[indexPath.row][:image][2]["#text"])))
      #cell.contentView.addSubview(img)
      cell.display_string = @artist[indexPath.row][:name]
    end
  end
end