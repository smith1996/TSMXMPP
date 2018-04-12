

Pod::Spec.new do |s|

  s.name         = 'TSMXMPP'
  s.version      = '1.0.0'
  s.summary      = 'This is such a TSMXMPP. Yah !!'
  s.description  = <<-DESC
This is some super TismartXMPP that was made by a crazy guy may may.
                       DESC
  s.homepage     = 'https://tismart.visualstudio.com/CORP_TSM_XMPP_LIBRARY/_git/CORP_TSM_XMPP_LIBRARY_iOS'

  s.license      = { :type => 'MIT', :file => "LICENSE" }
  s.author       = { 'Smith Huamani' => 'smithhh1996@gmail.com' }
  s.source       = { :git => 'https://tismart.visualstudio.com/CORP_TSM_XMPP_LIBRARY/_git/CORP_TSM_XMPP_LIBRARY_iOS', :tag => s.version.to_s }


  s.platform     = :ios, '10.0'
  s.ios.deployment_target = '10.0'
  s.requires_arc = true

  s.source_files  = 'TSMXMPP/*'

end
