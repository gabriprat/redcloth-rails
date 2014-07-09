# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redcloth-rails/version'

Gem::Specification.new do |s|
  s.name        = "redcloth-rails"
  s.version     = RedCloth::Rails::VERSION
  s.authors     = ["emjot"]
  s.email       = ["kontakt@emjot.de"]
  s.homepage    = "https://github.com/emjot/redcloth-rails"
  s.summary     = %q{Rails 3/4 engine which enables RedCloth and provides helpers for the awesome TextileEditor.}

  s.add_dependency('RedCloth',  '>= 4.2.0')
  s.add_dependency('rails',     '>= 3.1.0')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
