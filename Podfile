platform :ios, '9.0'
source 'https://github.com/CocoaPods/Specs.git'
inhibit_all_warnings!
target:'SecondMenuTest' do

pod "AFNetworking"
pod "FMDB"
pod "SDWebImage"
pod 'RegexKitLite-NoWarning'
pod 'DateTools'
pod 'Masonry'
pod 'TTTAttributedLabel'
pod 'DateTools'

pod 'YYText'
pod 'iOSDevFrameworks' , :git => 'http://gitlab.beijingyuanxin.com/ios/iOSDevFrameworks.git'

pod 'TZImagePickerController'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
        end
    end
end
