
Pod::Spec.new do |s|
  s.name             = 'RxAlamoRecord'
  s.version          = '1.1.0'
  s.summary          = 'RxAlamoRecord combines the power of the AlamoRecord and RxSwift libraries to create a networking layer that makes interacting with API\'s easier than ever reactively.'

  s.description      = <<-DESC
RxAlamoRecord combines the power of the AlamoRecord and RxSwift libraries to create a networking layer that makes interacting with API's easier than ever reactively.
                       DESC

  s.homepage         = 'https://github.com/Daltron/RxAlamoRecord'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daltron' => 'daltonhint4@gmail.com' }
  s.source           = { :git => 'https://github.com/Daltron/RxAlamoRecord.git', :tag => s.version.to_s }
  s.swift_version = '4.2'

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'RxAlamoRecord/Classes/**/*'
  s.requires_arc = true

  s.dependency 'AlamoRecord', '~> 1.3.0'
  s.dependency 'RxSwift', '~> 4.3.1'
  s.dependency 'RxCocoa', '~> 4.3.1'
  s.dependency 'Action', '~> 3.8.0'

end
