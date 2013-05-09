require 'rubygems'
require 'zake'

BetaBuilder::Tasks.new do |config|

  config.configuration = "Release"
  config.build_dir = "DerivedData/CollegeConnect/Build/Products"
  config.workspace_path = "CollegeConnect.xcworkspace"
  config.scheme = "CollegeConnect"
  config.app_name = "CollegeConnect"
  
end

namespace :xbuild do
  desc "Unlcok keychain"
  task :unlock_keychain do
    `security unlock-keychain -p 12344321 /Users/jenkins/Library/Keychains/login.keychain`
  end
  
  desc "Clean pods"
  task :clean_pods do
    puts "Clean pods"
    `rm -rf Pods`
  end

  desc "Update pods"
  task :install_pods => :clean_pods  do
    if File.exists?("Podfile.lock")
      puts "Update pods"
      sh "pod update" do |ok, err|
        if !ok
          `rm -rf Pods`
          `pod install`
        end
      end
    else
      `pod install`
    end
  end
  
  desc "Update build version"
  task :update_build_version do
    git_version = `git describe`
    puts "git_version:#{git_version}"
    components = git_version.split("-")
    app_version = components[0] || "0"
    build_version = components[1] || "0"
    puts "app_version:#{app_version}; build_version:#{build_version}"
    
    files = `ls`.split(/\n/)
    workspace_name = files.select{|e| e =~ /.*\.xcworkspace/}.last.gsub(".xcworkspace", "")
    plist_name = "#{workspace_name}/#{workspace_name}-Info.plist"
    `/usr/libexec/PlistBuddy -c "Set CFBundleVersion #{build_version}" #{plist_name}`
    `/usr/libexec/PlistBuddy -c "Set CFBundleShortVersionString #{app_version}" #{plist_name}`
  end
  
  desc "Build project"
  task :build_project => [:install_pods, :update_build_version, :unlock_keychain, "beta:package"]  do
    
  end
  
end
