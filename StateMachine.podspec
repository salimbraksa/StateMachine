Pod::Spec.new do |s|
  s.name         = "StateMachine"
  s.version      = "0.1"
  s.summary      = "Simple State Machine written in Swift"
  s.description  = <<-DESC
    The UYLPasswordManager class provides a simple wrapper around Apple Keychain
    Services on iOS devices. The class is designed to make it quick and easy to
    create, read, update and delete keychain items. Keychain groups are also
    supported as is the ability to set the data migration and protection attributes
    of keychain items.
    DESC
  s.homepage         = "https://github.com/salimbraksa/StateMachine"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.authors          = { "Salim Braksa" => "salim.braksa@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/salimbraksa/StateMachine.git", :tag => "0.1" }
  s.source_files  = "StateMachine"
end