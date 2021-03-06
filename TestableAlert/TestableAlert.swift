import UIKit

/**

A wrapper around UIAlertController for easier unit testing.

*/
public class TestableAlert {
  /// Alert object that was passed during initialization.
  public let alert: UIAlertController
  
  /// Array of alert actions with handlers
  var testableActions = [TestableAlertAction]()
  
  private var visiblePrivate = false
  
  /// Indicates if the alert is currently visible on screen.
  public var visible: Bool {
    get {
      return visiblePrivate
    }
  }
  
  /// Returns an array of actions added to the alert
  public var actions: [UIAlertAction] {
    get {
      return testableActions.map { $0.action }
    }
  }
  
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
    visiblePrivate = true
  }
  
  /**
  
  Adds an action to the alert.
  
  - parameter title: Action title. It is displayed as a title on the button.
  
  - parameter style: Style of the action.

  - parameter handler: An optional closure that will be called for the action.
  
  - returns: A new action object that was added to the alert.

  */
  public func addAction(title: String?, style: UIAlertActionStyle,
    handler: ((UIAlertAction) -> Void)?) -> UIAlertAction {
      
    let newAction = UIAlertAction(title: title, style: style, handler: handler)
    let testableAlertAction = TestableAlertAction(action: newAction, handler: handler)
    testableActions.append(testableAlertAction)
    alert.addAction(newAction)
    return newAction
  }
  
  /**

  Simulates a user executing an action. This method can be used in unit test. It calls the action handler and dismisses the alert.
  
  - parameter title: Title of an action to be executed. If multiple action have same titles the first one will be executed.

  */
  public func simulateAction(title: String) {
    guard let action = actionWithTitle(title) else { return }
    action.handler?(action.action)
    visiblePrivate = false
    alert.dismissViewControllerAnimated(false, completion: nil)
  }
  
  /**

  Returns an action that has a given title.

  - parameter title: Action title. It is displayed as a title on the button.
  
  - returns: Action that has a given title. Returns nil if there are no action with the title.

  */
  private func actionWithTitle(title: String) -> TestableAlertAction? {
    for testableAction in testableActions {
      if testableAction.action.title == title {
        return testableAction
      }
    }
    
    return nil
  }
}

/// Storage for an alert action and its handler
struct TestableAlertAction {
  let action: UIAlertAction
  let handler: ((UIAlertAction) -> Void)?
}