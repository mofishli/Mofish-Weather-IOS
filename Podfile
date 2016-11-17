platform :ios, '7.0'

target “Mofish” do  
pod 'LBBlurredImage'
pod 'AFNetworking', '~> 3.0'
pod 'MJRefresh'
pod 'AMSlideMenu'
pod 'SDWebImage'
end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'AMSlideMenuWithoutStoryboards']
        end
    end
    #fix for AMSlideMenu
    define = '#define SYSTEM_VERSION_LESS_THAN(v) ' +
    '([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)'
    
    directory = installer_representation.config.project_pods_root + 'Target Support Files/'
    info_plist_path = directory + "AMSlideMenu/AMSlideMenu-prefix.pch"
    
    text = File.read(info_plist_path)
    new_contents = text+define
    File.open(info_plist_path, "w") {|file| file.puts new_contents }
    
end

