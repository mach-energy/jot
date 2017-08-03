Pod::Spec.new do |s|
  s.name		= "MACH-jot"
  s.version		= "0.2.0"
  s.summary		= "An easy way to add drawings and text to images"
  s.homepage	= "https://github.com/IFTTT/jot"
  s.license		= 'MIT'
  s.author		= { 
                          "Laura Skelton" => "laura@ifttt.com",
                          "Max Meyers" => "max@ifttt.com",
                          "Devin Foley" => "devin@ifttt.com" 
                          }
  s.source    = { :git => "https://github.com/mach-energy/jot.git" }

  s.social_media_url	= 'https://twitter.com/skelovenko'
  s.platform		= :ios, '8.0'
  s.requires_arc	= true
  s.compiler_flags	= '-fmodules'
  s.frameworks		= 'UIKit'

  s.dependency		  'Masonry', '~> 1.0.2'
  s.source_files	= 'jot/*.{h,m}'
  
end
