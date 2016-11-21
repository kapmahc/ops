$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'ops/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'ops'
  s.version     = Ops::VERSION
  s.authors     = ['Jitang Zheng']
  s.email       = ['jitang.zheng@gmail.com']
  s.homepage    = 'https://github.com/kapmahc/ops'
  s.summary     = 'ops engine.'
  s.description = 'ops.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.0.0', '>= 5.0.0.1'

  s.add_development_dependency 'sqlite3'
end
