# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Homebase-Task' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  # Pods for Homebase-Task
    pod 'RxSwift' ,'6.2.0'
    pod 'RxCocoa' ,'6.2.0'
  target 'Homebase-TaskTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RxBlocking','6.2.0'
  end
end
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
