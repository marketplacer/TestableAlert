import XCTest
@testable import TestableAlert

class SimulateActionsTests: XCTestCase {
  var alert: UIAlertController!
  var obj: TestableAlert!
  var didCallAction1Closure = false
  var didCallAction2Closure = false
  
  override func setUp() {
    super.setUp()
    
    alert = UIAlertController(title: "Test title",
      message: "Test message", preferredStyle: .ActionSheet)
    
    obj = TestableAlert(alert: alert)
    
    // Add first action
    // -----------------
    
    didCallAction1Closure = false
    
    let myAction1Handler = { (action: UIAlertAction) -> Void in
      self.didCallAction1Closure = true
    }
    
    obj.addAction("Action 1", style: .Destructive, handler: myAction1Handler)
    
    // Add second action
    // -----------------
    
    didCallAction2Closure = false
    
    let myAction2Handler = { (action: UIAlertAction) -> Void in
      self.didCallAction2Closure = true
    }
    
    obj.addAction("Action 2", style: .Destructive, handler: myAction2Handler)
  }
  
  func testAddAction_savesHandler() {
    obj.simulateAction("Action 1")
    XCTAssert(didCallAction1Closure)
    XCTAssertFalse(didCallAction2Closure)
  }
}
