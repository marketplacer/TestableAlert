import UIKit

struct TestableAlertAction {
  let action: UIAlertAction
  let handler: ((UIAlertAction) -> Void)?
}