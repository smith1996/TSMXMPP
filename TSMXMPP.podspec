

Pod::Spec.new do |s|

  s.name         = "TSMXMPP"
  s.version      = "1.0.0"
  s.summary      = "This is such a TSMXMPP. Yah !!"
  s.description  = "This is some super TismartXMPP that was made by a crazy guy may may."
  s.homepage     = "https://github.com/smith1996/TSMXMPP"

  s.license      = 'MIT'
  s.author       = { "Smith Huamani" => "smithhh1996@gmail.com" }
  s.source       = { :git => "https://github.com/smith1996/TSMXMPP.git"}


  s.platform     = :ios, '10.0'
  s.ios.deployment_target = '10.0'
  s.requires_arc = true

  s.dependency 'XMPPFramework'
  s.ios.frameworks = 'XMPPFramework'
  s.source_files  = "TSMXMPP/**/*.{h,m}"

end
