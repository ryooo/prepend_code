# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'prepend_code/version'

Gem::Specification.new do |gem|
  gem.name          = "prepend_code"
  gem.version       = PrependCode::VERSION
  gem.authors       = ["ryooo321"]
  gem.email         = ["ryooo.321@gmail.com"]
  gem.description   = %q{Prepend context on all app ruby files. coding directive, copy right and so on.}
  gem.summary       = %q{Prepend context on all app ruby files.}
  gem.homepage      = "https://github.com/ryooo321/prepend_code"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_runtime_dependency "OptionParser"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "rspec"
end
