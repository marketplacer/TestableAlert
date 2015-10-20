import XCTest
@testable import TestableAlert

class TestableAlertTests: XCTestCase {
  var alert: UIAlertController!
  var obj: TestableAlert!
  
  override func setUp() {
    super.setUp()
    
    alert = UIAlertController(title: "Test title",
      message: "Test message", preferredStyle: .ActionSheet)
    
    obj = TestableAlert(alert: alert)
  }
  
  func testInitialize() {
    XCTAssert(obj.alert === alert)
  }
  
  func testPresent() {
    let viewController = UIViewController()
    obj.present(viewController)
  }
  
  // MARK: - Actions
  
  func testAddAction() {
    let myActionHandler = { (action: UIAlertAction) -> Void in }
    let result = obj.addAction("Test action", style: .Destructive, handler: myActionHandler)
    
    XCTAssertEqual("Test action", result.title)
    
    XCTAssertEqual(1, obj.testableActions.count)
    XCTAssertEqual("Test action", obj.testableActions.first?.action.title)
    
    XCTAssertEqual(1, obj.actions.count)
    XCTAssertEqual("Test action", obj.actions.first?.title)
  }
  
  func testAddAction_savesHandler() {
    var didCallClosure = false
    let myActionHandler = { (action: UIAlertAction) -> Void in
      didCallClosure = true
    }
    
    obj.addAction("Test action", style: .Destructive, handler: myActionHandler)
    let testableAction = obj.testableActions.first!
    testableAction.handler?(testableAction.action)
    
    XCTAssert(didCallClosure)
  }
}
