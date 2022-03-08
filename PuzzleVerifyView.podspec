
Pod::Spec.new do |spec|
  spec.name         = "PuzzleVerifyView"
  spec.version      = "0.0.1"
  spec.summary      = "滑动拼图"
  spec.description  = "自定义的滑动拼图"
  spec.homepage     = "https://github.com/o4444kng/PuzzleVerifyView"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "陈柏" => "873849760@qq.com" }
  spec.platform     = :ios
  spec.platform     = :ios, "9.0"
  spec.ios.deployment_target = "9.0"
  spec.source       = { :git => "https://github.com/o4444kng/PuzzleVerifyView.git", :tag => "#{spec.version}" }
  spec.source_files  = "Classes", "Classes/*.swift"


end
