import UIKit

/**

A wrapper around UIAlertAction for easier unit testing.

*/
public class TestableAlert {
  let alert: UIAlertController
  var actions = [TestableAlertAction]()
  
  /**

  Creates a new alert wrapper.
  
  - parameter alert: An alert to be user.

  */
  public init(alert: UIAlertController) {
    self.alert = alert
  }
  
  /**
  
  Present the alert in the view controller.
  
  - parameter inViewController: A view controller that will be used to show the alert.

  */
  public func present(inViewController: UIViewController) {
    inViewController.presentViewController(alert, animated: true, completion: nil)
  }
  
  /**
  
  Add an action to the alert.
  
  - parameter title: Action title. It is displayed as a title on the button.
  
  - parameter style: Style of the action.

  - parameter handler: An optional closure that will be called for the action.

  */
  public func addAction(title: String?, style: UIAlertActionStyle, handler: ((UIAlertAction) -> Void)?) {
    let newAction = UIAlertAction(title: title, style: style, handler: handler)
    let testableAlertAction = TestableAlertAction(action: newAction, handler: handler)
    actions.append(testableAlertAction)
    alert.addAction(newAction)
  }
}