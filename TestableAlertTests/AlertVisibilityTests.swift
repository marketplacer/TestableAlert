import XCTest
@testable import TestableAlert

class AlertVisibilityTests: XCTestCase {
  var alert: UIAlertController!
  var obj: TestableAlert!
  
  override func setUp() {
    super.setUp()
    
    alert = UIAlertController(title: "Test title",
      message: "Test message", preferredStyle: .ActionSheet)
    
    obj = TestableAlert(alert: alert)
  }
  
  func testNotVisibleInitially() {
    XCTAssertFalse(obj.visible)
  }
  
  func testVisibleAfterPresented() {
    let viewController = UIViewController()
    obj.present(viewController)
    
    XCTAssert(obj.visible)
  }
  
  func testNotVisible_afterPresentedAndClosed() {
    let viewController = UIViewController()
    obj.addAction("My action", style: .Destructive, handler: nil)
    obj.present(viewController)
    obj.simulateAction("My action")
    
    XCTAssertFalse(obj.visible)
  }
  
  func testKeepVisibleIfSimulatedActionDoesNotExist() {
    let viewController = UIViewController()
    obj.present(viewController)
    obj.simulateAction("My action")

    XCTAssert(obj.visible)
  }
}
