import UIKit

public class TestableAlert {
  public init() {}
  
  public func present(alert: UIAlertViewControll, inViewController: UIViewController) {
    inViewController.presentViewController(alert, animated: true, completion: nil)
  }
}

public class MyClass {
  
  
}