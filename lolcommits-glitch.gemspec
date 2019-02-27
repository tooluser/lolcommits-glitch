# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lolcommits/glitch/version'

Gem::Specification.new do |spec|
  spec.name          = "lolcommits-glitch"
  spec.version       = Lolcommits::Glitch::VERSION
  spec.authors       = ["Joshua Marker"]
  spec.email         = ["joshua@nowhereville.org"]

  spec.summary       = %q{Glitch up your lolcommits}
  spec.description   = %q{Glitch and subliminal messages to delight your colleagues}

  spec.homepage      = "https://github.com/tooluser/lolcommits-glitch"
  spec.license       = "LGPL-3.0"

  spec.metadata = {
    "homepage_uri"    => "https://github.com/tooluser/lolcommits-glitch",
    "changelog_uri"   => "https://github.com/tooluser/lolcommits-glitch/blob/master/CHANGELOG.md",
    "source_code_uri" => "https://github.com/tooluser/lolcommits-glitch",
    "bug_tracker_uri" => "https://github.com/tooluser/lolcommits-glitch/issues",
  }

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

 spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|features)/}) }
  spec.test_files    = `git ls-files -- {test,features}/*`.split("\n")
  spec.bindir        = "bin"
  spec.executables   = []
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.1"

  spec.add_dependency "rmagick", "~> 3.0", ">= 3.0.0"
  spec.add_dependency "faker", "~> 1.8", ">= 1.8.7"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "lolcommits", "~> 0.12", ">= 0.12.0"
  spec.add_development_dependency "bundler", "~> 2.0", ">= 2.0.0"
  spec.add_development_dependency "rake", "~> 12.3", ">= 12.3.0"
  spec.add_development_dependency "pry"
end
