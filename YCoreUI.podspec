Pod::Spec.new do |s|
  s.name                    = 'YCoreUI'
  s.version                 = '1.7.0'
  s.summary                 = 'Core components for iOS to accelerate building user interfaces in code.'
  s.homepage                = 'https://yml-org.github.io/YCoreUI'
  s.license                 = { :type => 'Apache 2.0' }
  s.authors                 = { 'Y Media Labs' => 'support@ymedialabs.com' }
  s.source                  = { :git => 'https://github.com/yml-org/YCoreUI.git', :tag => s.version }
  s.ios.deployment_target   = '14.0'
  s.tvos.deployment_target  = '14.0'
  s.swift_versions          = ['5']
  s.source_files            = 'Sources/YCoreUI/**/*'
end
