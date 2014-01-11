class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @top_artist_controller = TopArtistController.alloc.initWithCollectionViewLayout(UICollectionViewFlowLayout.alloc.init)
    @similar_artist_controller = SimilarArtistController.alloc.initWithCollectionViewLayout(UICollectionViewFlowLayout.alloc.init)
    @window.rootViewController = createTabBar
    @window.makeKeyAndVisible
    true
  end

  def createTabBar
    tab_bar_controller = UITabBarController.alloc.init
    tab_bar_controller.viewControllers = [
      UINavigationController.alloc.initWithRootViewController(@top_artist_controller),
      UINavigationController.alloc.initWithRootViewController(@similar_artist_controller)
    ]
    tab_bar_controller
  end
end
