class TopArtistController < UIViewController
  def init
    super
    self.title = "Top Artists"
    self.tabBarItem = UITabBarItem.alloc.initWithTabBarSystemItem(UITabBarSystemItemFeatured, tag: 1)
    self
  end

  def viewDidLoad
    view.backgroundColor = UIColor.scrollViewTexturedBackgroundColor
    setupNavigationBar
    fetch
  end

  def setupNavigationBar
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    right_button_item = UIBarButtonItem.alloc.initWithTitle('Add', style:UIBarButtonItemStyleBordered,target: self, action: "click_add")
    self.navigationItem.setRightBarButtonItem(right_button_item)
  end

  def click_add
    #add
  end

  def fetch
    data = Fetch.top_artists
    p "voor"
    p data
    p "na"
  end
end