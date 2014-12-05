#
# Be sure to run `pod lib lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "BITableDataSourceComposite"
  s.version          = "1.0"
  s.summary          = "UITableViewDataSource that can display cells from multiple UITableViewDataSources, with optional headers for each UITableViewDataSource."
  s.description      = "UITableViewDataSource that can display cells from multiple UITableViewDataSources, with optional headers for each UITableViewDataSource."
  s.homepage         = "http://brightinventions.pl"
  s.license          = 'MIT'
  s.author           = { "Daniel Makurat" => "daniel.makurat@brightinventions.pl" }
  s.source           = { :git => "https://github.com/bright/BITableDataSourceComposite.git", :tag => s.version.to_s }
  s.platform     = :ios, '5.0'
  s.ios.deployment_target = '5.0'
  s.requires_arc = true
  s.source_files = 'BITableDataSourceComposite/lib/**/*.{h,m}'
  s.public_header_files = 'BITableDataSourceComposite/lib/**/*.h'
end
