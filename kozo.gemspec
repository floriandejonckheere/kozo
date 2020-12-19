# frozen_string_literal: true

require_relative "lib/kozo/version"

Gem::Specification.new do |spec|
  spec.name          = "kozo"
  spec.version       = Kozo::VERSION
  spec.authors       = ["Florian Dejonckheere"]
  spec.email         = ["florian@floriandejonckheere.be"]

  spec.summary       = "Declarative cloud infrastructure"
  spec.description   = "Declaratively create, modify and destroy cloud infrastructure in your favourite language"
  spec.homepage      = "http://github.com/floriandejonckheere/kozo"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.2")

  spec.metadata["source_code_uri"] = "https://github.com/floriandejonckheere/kozo"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r(^bin/)) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport"
  spec.add_runtime_dependency "zeitwerk"

  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-performance"
  spec.add_development_dependency "rubocop-rspec"

  spec.add_development_dependency "climate_control"
  spec.add_development_dependency "factory_bot"
  spec.add_development_dependency "ffaker"
  spec.add_development_dependency "overcommit"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rspec", "~> 3.10"
  spec.add_development_dependency "shoulda-matchers"
  spec.add_development_dependency "super_diff"
  spec.add_development_dependency "timecop"
  spec.add_development_dependency "webmock"
end
