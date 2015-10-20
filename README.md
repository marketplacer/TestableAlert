🚧🚧🚧 This is work in progress 🚧🚧🚧

# UIAlertController wrapper for easier unit testing

This is an iOS library written in Swift that makes it easier to test the code that shows UIAlertController alerts. The library allows to check alert visibility and execute its actions from the unit tests.

## Setup

There are three ways you can add TestableAlert to your project.

**Add source (iOS 7+)**

Simply add [TestableAlert.swift](https://github.com/exchangegroup/TestableAlert/blob/master/TestableAlert/TestableAlert.swift) file into your Xcode project.

**Setup with Carthage (iOS 8+)**

Add `github "exchangegroup/TestableAlert" ~> 1.0` to your Cartfile and run `carthage update`.

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

2) In the code that shows the alert initialize an UIAlertController object like you would normally do.

```Swift
let alertController = UIAlertController(
  title: "Do you want to cancel this operation?", message: nil,
  preferredStyle: .ActionSheet)
```

3) Create an instance of `TestableAlert` supplying the alert instance you just created.

```Swift
testableAlert = TestableAlert(alert: alertController)
```

4) Add actions to the testable alert instance instead of the alert controller.

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

    testableAlert?.addAction("OK", style: .Destructive, handler: nil) { _ in
      // Do something
    }

    testableAlert?.addAction("Cancel", style: .Cancel, handler: nil)

    testableAlert?.present(self)
  }
}
```


## Testing alert

Here is how you can verify the alert and execute its actions from your view controller unit test.

1) Check if alert is visible.

```Swift
XCTAssert(viewController.testableAlert.visible)
```

2) Execute an action by its title. This will call the action handler and dismiss the alert. The method `simulateAction` is the main reason this library exists.

```Swift
viewController.testableAlert.simulateAction("OK")
```


## License

TestableAlert library is released under the [MIT License](LICENSE).




