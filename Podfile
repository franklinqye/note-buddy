# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'note-buddy' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for note-buddy
    pod 'ChameleonFramework/Swift', :git => 'https://github.com/ViccAlexander/Chameleon.git'


  target 'note-buddyTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'note-buddyUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        puts target.name
    end
end
