Pod::Spec.new do |s|

  s.name         = "DevelopMesser"
  s.version      = "0.0.1"
  s.summary      = "IOS常用的开发工具包"
  s.homepage     = "https://github.com/lordking/DevelopMesser"
  s.license      = 'MIT'
  s.author             = { "lordking" => "lordking@163.com" }
  s.social_media_url = "http://weibo.com/leking"
  s.requires_arc = true

  s.platform     = :ios, '6.0'
  s.source       = { :git => "https://github.com/lordking/DevelopMesser.git", :tag => "0.0.1"}
  s.public_header_files = 'DevelopMesser/*.h'
  s.source_files  = 'DevelopMesser/*.{h,m}'

end