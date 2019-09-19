
Pod::Spec.new do |s|
  s.name             = 'RxAlamoRecord'
  s.version          = '2.2.2'
  s.summary          = 'An elegant Reactive wrapper around AlamoRecord.'

  s.description      = <<-DESC
RxAlamoRecord combines the power of the AlamoRecord and RxSwift libraries to create a networking layer that makes interacting with API's easier than ever reactively.
                       DESC

  s.homepage         = 'https://github.com/Daltron/RxAlamoRecord'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daltron' => 'daltonhint4@gmail.com' }
  s.source           = { :git => 'https://github.com/Daltron/RxAlamoRecord.git', :tag => s.version.to_s }
  s.swift_version = '5.1'

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'

  s.source_files = 'RxAlamoRecord/Classes/**/*'
  s.requires_arc = true

  s.dependency 'AlamoRecord', '~> 2.2.1'
  s.dependency 'RxSwift', '~> 5.0.0'
  s.dependency 'RxCocoa', '~> 5.0.0'
  s.dependency 'Action', '~> 4.0.0'

end
