Pod::Spec.new do |spec|
  spec.name = 'SKStringFormatter'
  spec.version = '0.0.3'
  spec.license = 'MIT'
  spec.summary = 'A flexible formatter for strings.'
  spec.homepage = 'https://github.com/skladek/SKStringFormatter'
  spec.authors = { 'Sean Kladek' => 'skladek@gmail.com' }
  spec.source = { :git => 'https://github.com/skladek/SKStringFormatter.git', :tag => spec.version }
  spec.ios.deployment_target = '9.0'
  spec.source_files = 'Source/*.swift'
end
