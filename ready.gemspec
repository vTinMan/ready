# coding: utf-8
lib = File.expand_path('./lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative './lib/ready/version'

Gem::Specification.new do |spec|
  spec.name          = "ready"
  spec.version       = Ready::VERSION
  spec.authors       = ["Valentin Vasilevskiy"]
  spec.email         = ["tin.vsl@gmail.com"]
  spec.summary       = %q{Dependency Injection (DI) on pure Ruby}
  spec.description   = %q{This gem implement IoC on pure Ruby without using special containers. It set DSL of IoC design pattern.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]
end
