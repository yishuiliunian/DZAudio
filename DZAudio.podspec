#
# Be sure to run `pod lib lint YHNetCore.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "DZAudio"
  s.version          = "0.1.1"
  s.summary          = "A short description of DZAudio."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
			DZAudio is tool to recorder and play some audio file
                       DESC

  s.homepage         = "https://github.com/<GITHUB_USERNAME>/YHNetCore"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "stonedong" => "yishuiliunian@gmail.com" }
  s.source           = { :git => "https://github.com/<GITHUB_USERNAME>/YHNetCore.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.source_files = 'Classes/**/*'
  s.resource_bundles = {
    'DZAudio' => ['Assets/*.png']
  }

  #

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'AVFoundation'
  s.dependency 'DZFileUtils'
  s.dependency 'DZSinglonFactory'
end
