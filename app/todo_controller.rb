class ToDoController < UIViewController
  def init
    super
    self.title = "ToListen"
    self.tabBarItem = UITabBarItem.alloc.initWithTabBarSystemItem(UITabBarSystemItemTopRated, tag: 1)
    self
  end

  def viewDidLoad
    view.backgroundColor = UIColor.scrollViewTexturedBackgroundColor
    setupNavigationBar
  end

  def setupNavigationBar
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    right_button_item = UIBarButtonItem.alloc.initWithTitle('Add', style:UIBarButtonItemStyleBordered,target: self, action: "popActionSheet")
    self.navigationItem.setRightBarButtonItem(right_button_item)
  end

  def click_add
    #add
  end

  def popActionSheet
    UIActionSheet.alloc.initWithTitle("Options",
    delegate: self,
    cancelButtonTitle: "Cancel",
    destructiveButtonTitle: nil,
    otherButtonTitles: "Test 1", "Test 2", nil).showInView(view)
  end
end