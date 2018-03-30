# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'text_exclude/version'

Gem::Specification.new do |spec|
  spec.name        = 'TextExclude'
  spec.version     = TextExclude::VERSION
  spec.authors     = ['Richard Bradley Smith']
  spec.email       = ['rsmithsc@yahoo.com']

  spec.summary     = 'Productivity tool for text files'
  spec.description = 'TextExclude provides a number of function including ' \
                     'locating hard to find things in code. It is also ' \
                     'useful for cleaning up bad data, creating specific ' \
                     'test data and general data related actions one would ' \
                     'need a script for but does not merit writing.'
  spec.homepage    = 'https://richardbradleysmith.com'
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set
  # the 'allowed_push_host' to allow pushing to a single host or delete
  # this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'TODO: Set to "http://mygemserver.com"'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'test-unit', '~> 3.2'
end
