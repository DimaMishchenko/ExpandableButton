Pod::Spec.new do |s|
  s.name             = 'ExpandableButton'
  s.version          = '1.0.0'
  s.summary          = 'ExpandableButton'
 
  s.description      = <<-DESC
 Customizable and easy to use expandable button in Swift.
                       DESC
 
  s.homepage         = 'https://github.com/DimaMishchenko/ExpandableButton'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dima Mishchenko' => 'narmdv5@gmail.com' }
  s.source           = { :git => 'https://github.com/DimaMishchenko/ExpandableButton.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '9.0'
  s.source_files = 'ExpandableButton/*'
 
end