Pod::Spec.new do |s|
  s.name        = "TestableAlert"
  s.version     = "1.0.3"
  s.license     = { :type => "MIT" }
  s.homepage    = "https://github.com/exchangegroup/TestableAlert"
  s.summary     = "A UIAlertController wrapper for easier unit testing written in Swift"
  s.description  = <<-DESC
                   This is an iOS library written in Swift that makes it easier to test UIAlertController alerts. The library allows to check alert visibility and execute its actions from the unit tests.
                   DESC
  s.authors     = { "Evgenii Neumerzhitckii" => "sausageskin@gmail.com" }
  s.source      = { :git => "https://github.com/exchangegroup/TestableAlert.git", :tag => s.version }
  s.source_files = "TestableAlert/**/*.swift"
  s.ios.deployment_target = "8.0"
end