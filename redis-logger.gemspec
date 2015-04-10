# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redis/logger/version'

Gem::Specification.new do |spec|
  spec.name          = 'redis-logger'
  spec.version       = Redis::Logger::VERSION
  spec.authors       = ['Martin Englund']
  spec.email         = ['martin@englund.nu']

  spec.summary       = 'Log device to be used with the standard Ruby logger, which logs to Redis.'
  spec.homepage      = 'http://skalera.com'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(/^(test|spec|features)\//) }
  spec.require_paths = ['lib']

  spec.add_dependency 'redis', '~> 3.2'
  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'rubocop', '~> 0.29'
end
