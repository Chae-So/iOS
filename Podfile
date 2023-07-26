# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ChaeSo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ChaeSo
  pod 'DropDown', '2.3.13'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |build_configuration|
      build_configuration.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
    end
  end
end