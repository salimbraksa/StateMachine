Pod::Spec.new do |s|
  s.name         = "StateMachine"
  s.version      = "0.1"
  s.summary      = "Simple State Machine written in Swift"
  s.description  = <<-DESC
    The StateMachine class provides a set of states and transitions that describe the lifecycle of an object.  
    DESC
  s.homepage         = "https://github.com/salimbraksa/StateMachine"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.authors          = { "Salim Braksa" => "salim.braksa@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/salimbraksa/StateMachine.git", :tag => "0.1" }
  s.source_files  = "StateMachine"
end