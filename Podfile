platform :ios, '9.0'

use_frameworks!
inhibit_all_warnings!

target 'SKStringFormatter' do
	project 'SKStringFormatter.xcodeproj'
	workspace 'SKStringFormatter.xcworkspace'
	pod 'SwiftLint', '= 0.19.0'
end

target 'SKStringFormatterTests' do
	project 'SKStringFormatter.xcodeproj'
	pod 'Nimble', '= 7.0.0'
	pod 'Quick', '= 1.1.0'
end

target 'SampleProject' do
	project 'SampleProject/SampleProject.xcodeproj'
	pod 'SKTableViewDataSource', '= 0.0.3'
end