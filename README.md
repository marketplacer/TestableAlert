# A UIAlertController wrapper for easier unit testing in iOS / Swift

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)][carthage]
[![CocoaPods Version](https://img.shields.io/cocoapods/v/TestableAlert.svg?style=flat)][cocoadocs]
[![License](https://img.shields.io/cocoapods/l/TestableAlert.svg?style=flat)](LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/TestableAlert.svg?style=flat)][cocoadocs]
[cocoadocs]: http://cocoadocs.org/docsets/TestableAlert
[carthage]: https://github.com/Carthage/Carthage

This is an iOS library written in Swift that makes it easier to test UIAlertController alerts. The library allows to check alert visibility and execute its actions from the unit tests.

Example of a unit test for a remove button that shows an alert with two actions: "Remove" and "Close".

```Swift
func testTapRemove() {
  viewController.didTapRemoveButton(UIButton())

  // Verify alert is presented
  XCTAssert(viewController.testableAlert!.visible)

  // Verify alert title
  XCTAssertEqual(viewController.testableAlert!.alert.title, "Do you want to remove this item?")

  // Verify the buttons
  XCTAssertEqual(viewController.testableAlert!.actions.count, 2)
  XCTAssertEqual(viewController.testableAlert!.actions[0].title, "Yes, remove this item")
  XCTAssertEqual(viewController.testableAlert!.actions[1].title, "Close")

  // Press "Remove" button
  viewController.testableAlert.simulateAction("Yes, remove this item")

  // Verify the item was removed
  XCTAssert(viewController.itemIsRemoved)
}
```

## Setup

There are three ways you can add TestableAlert to your project.

**Add source (iOS 7+)**

Simply add [TestableAlert.swift](https://github.com/marketplacer/TestableAlert/blob/master/TestableAlert/TestableAlert.swift) file into your Xcode project.

**Setup with Carthage (iOS 8+)**

Add `github "marketplacer/TestableAlert" ~> 1.0` to your Cartfile and run `carthage update`.

**Setup with CocoaPods (iOS 8+)**

If you are using CocoaPods add this text to your Podfile and run `pod install`.

    use_frameworks!
    pod 'TestableAlert', '~> 1.0'


## Usage

Add `import TestableAlert` to your source code if you used Carthage or CocoaPods setup methods.

1) Create an instance property in your view controller where you want to show the alert.

```
class ViewController: UIViewController {
  var testableAlert: TestableAlert?
  // ...
}
```

2) In the code that shows the alert initialize a UIAlertController object like you would normally do.

```Swift
let alertController = UIAlertController(
  title: "Do you want to cancel this operation?", message: nil,
  preferredStyle: .ActionSheet)
```

3) Create an instance of `TestableAlert` supplying the alert you just created.

```Swift
testableAlert = TestableAlert(alert: alertController)
```

4) Add actions to the testable alert instance.

```Swift
testableAlert?.addAction("OK", style: .Destructive) { _ in
  // Do something
}
```

5) Present the alert in the view controller.

```Swift
testableAlert?.present(self)
```

Here is the full code for a view controller:

```Swift
import UIKit
import TestableAlert

class ViewController: UIViewController {

  var testableAlert: TestableAlert?

  func showAlert() {
    let alertController = UIAlertController(
      title: "Do you want to cancel this operation?", message: nil, preferredStyle: .ActionSheet)

    testableAlert = TestableAlert(alert: alertController)

    testableAlert?.addAction("OK", style: .Destructive) { _ in
      // Do something
    }

    testableAlert?.addAction("Cancel", style: .Cancel, handler: nil)

    testableAlert?.present(self)
  }
}
```


## Testing the alert

Here is how you can verify the alert and execute its actions from your view controller unit test.

#### Get alert object

In your tests you will most likely need to get the the UIAlertController object to verify its title, message, text fields etc. It can be done by accessing `alert` property.

```Swift
testableAlert.alert
```

#### Check alert visibility

Check the `visible` property to see if the alert has been presented.

```Swift
XCTAssert(testableAlert.visible)
```

#### Execute an action by its title

Call `simulateAction` method to simulate an action. It will call the action handler and dismiss the alert.

```Swift
testableAlert.simulateAction("OK")
```

#### Get list of alert actions

Use the `actions` property to get UIAlertAction objects for the alert.

```Swift
testableAlert.actions
```


## License

TestableAlert library is released under the [MIT License](LICENSE).




