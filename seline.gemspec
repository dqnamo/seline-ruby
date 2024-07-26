# frozen_string_literal: true

require_relative "lib/seline/version"

Gem::Specification.new do |spec|
  spec.name = "seline"
  spec.version = Seline::VERSION
  spec.authors = ["John Paul"]
  spec.email = ["johnarpaul@gmail.com"]

  spec.summary = "Ruby wrapper for seline.so API"
  spec.description = "Ruby wrapper for seline.so API"
  spec.homepage = "https://github.com/dqnamo/seline-ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = "https://github.com/dqnamo/seline-ruby"
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = Dir.glob("lib/**/*.rb")
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
