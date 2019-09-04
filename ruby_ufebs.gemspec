# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ufebs/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby_ufebs"
  spec.version       = RubyUfebs::VERSION
  spec.authors       = ["Evgeniy Burdaev"]
  spec.email         = ["hate2me@yandex.ru"]

  spec.summary       = %q{Simple Construction of XML Defined by UFEBS for 2017/2018 standards http://www.cbr.ru/analytics/?PrtId=Formats}
  spec.homepage      = "https://github.com/creepycheese/ruby_ufebs"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-minitest'
  spec.add_development_dependency 'guard-bundler'
  spec.add_development_dependency 'yard'
  spec.add_runtime_dependency 'nokogiri-happymapper'
end
