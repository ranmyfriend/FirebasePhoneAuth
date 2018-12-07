# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'FirebasePhone' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    inhibit_all_warnings!

    pod 'Firebase/Auth'
    pod 'Firebase/Core'

    target 'FirebasePhoneTests' do
        inherit! :search_paths
        pod 'Firebase/Auth'
        pod 'Firebase/Core'
    end
end
