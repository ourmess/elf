# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

require 'motion-testflight'
require 'bubble-wrap/core'
require 'bubble-wrap/location'
require 'bubble-wrap/ui'
require 'formotion'

# https://github.com/clayallsopp/formotion/issues/209
ENV['ARR_CYCLES_DISABLE'] ||= '1'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Collector'
  app.identifier = 'com.t4.collector'
  app.version = '0.0.1.5'
  app.short_version = '0.0.1.5'
  app.deployment_target =  '6.0'
  app.prerendered_icon = true
  app.sdk_version = '8.1'
  app.delegate_class = 'AppDelegate'
  app.provisioning_profile = './CollectorProvisioningProfile.mobileprovision'
  app.icons = ['Icon-60','Icon-60@2x','Icon-60@3x','Icon-76','Icon-76@2x','Icon-Small-40','Icon-Small-40@2x','Icon-Small','Icon-Small@2x','Icon-Small@3x','Icon-57']

  app.entitlements['aps-environment'] = 'development'
  app.entitlements['get-task-allow'] = true

  app.info_plist['NSLocationAlwaysUsageDescription'] = 'Collector will occasionally access your device location in the background for asset tracking purposes'
  app.info_plist['NSLocationWhenInUseUsageDescription'] = 'Collector will access your device location to determine the location of any given asset'
  #app.info_plist['UIViewControllerBasedStatusBarAppearance'] = false

  app.testflight.sdk = 'vendor/TestFlightSDK3.0.2'
  app.testflight.api_token = '<api_token>'
  app.testflight.team_token = '<team_token>'
  app.testflight.app_token = '<app_token>'
  
end
