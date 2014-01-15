class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    top_artist_ctrl = TopArtistController.alloc.initWithCollectionViewLayout(UICollectionViewFlowLayout.alloc.init)
    similar_artist_ctrl = SimilarArtistController.alloc.initWithCollectionViewLayout(UICollectionViewFlowLayout.alloc.init)
    @window.rootViewController = createTabBar(top_artist_ctrl, similar_artist_ctrl)
    @window.makeKeyAndVisible
    true
  end

  def createTabBar(tab1,tab2)
    tab_bar_controller = UITabBarController.alloc.init
    tab_bar_controller.viewControllers = [
      UINavigationController.alloc.initWithRootViewController(tab1),
      UINavigationController.alloc.initWithRootViewController(tab2)
    ]
    tab_bar_controller
  end
end
