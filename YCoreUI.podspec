#
#  Be sure to run `pod spec lint YCoreUI.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#

Pod::Spec.new do |spec|
  spec.name             = "YCoreUI"
  spec.version          = "1.0.2"
  spec.summary          = "Core components for iOS to accelerate building user interfaces in code."
  spec.description      = "This framework comprises UIView extensions for declarative AutoLayout, UIColor extensions for WCAG 2.0 contrast ratio calculations, and UIScrollView extensions to assist with keyboard avoidance."
  spec.homepage         = "https://github.com/yml-org/YCoreUI"
  spec.license          = "Apache License, Version 2.0"
  spec.author           = "Mark Pospesel, Sanjib Chakraborty, Sumit Goswami, Karthik K Manoj, Visakh Tharakan, et al"
  spec.social_media_url = "https://twitter.com/Yml_co"
  spec.platform         = :ios, "14.0"
  spec.swift_version    = '5.5'
  spec.source           = { :git => "https://github.com/yml-org/YCoreUI.git", :tag => spec.version }
  spec.source_files     = "Sources/**/*"
end
