Pod::Spec.new do |s|
  s.name             = "PodInfoController"
  s.version          = "0.1.0"
  s.summary          = "PodInfoController provides methods to list the current installed pods in your app."
  s.description      = <<-DESC
                       PodInfoController integrates the Podfile.lock in your app target.
                       It also provides some methods to retrieve that information.
                       This may be useful for developers and testers to check, which exact version of a cocoapod is used in a certain app version
                       DESC
  s.homepage         = "https://github.com/jschuster/PodInfoController"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Joachim Schuster" => "joachim.schuster@venqoo.com" }
  s.source           = { :git => "https://github.com/jschuster/PodInfoController.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'PodInfoController' => ['Pod/Resources/*']
  }

  s.dependency 'YAML-Framework', '~> 0.0'
end
