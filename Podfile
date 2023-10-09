# Uncomment the next line to define a global platform for your project
# platform :ios, '11.0'

target 'PracticeFirebaseUI' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for PracticeFirebaseUI
  pod 'FirebaseUI'       # Pull in all Firebase UI features


  # Post install
  post_install do |installer|
    #iOS deployment version
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      end
    end
  end
end
