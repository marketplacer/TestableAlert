import UIKit
import TestableAlert

class ViewController: UIViewController {
  
  var testableAlert: TestableAlert?

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func didTapShowAlertButton(sender: AnyObject) {
    let alertController = UIAlertController(
      title: "Do you want to cancel this operation?", message: nil, preferredStyle: .ActionSheet)
    
    testableAlert = TestableAlert(alert: alertController)
    testableAlert?.addAction("OK", style: .Destructive, handler: nil)
    testableAlert?.addAction("Cancel", style: .Cancel, handler: nil)
    
    testableAlert?.present(self)    
  }
}

