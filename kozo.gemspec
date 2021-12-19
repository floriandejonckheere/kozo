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
  spec.required_ruby_version = Gem::Requirement.new(">= 3.0.0")

  spec.metadata["source_code_uri"] = "https://github.com/floriandejonckheere/kozo"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|docs|bin|.github|.rspec|.rubocop.yml)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = ["kozo"]
  spec.require_paths = ["lib"]

  spec.metadata = {
    "rubygems_mfa_required" => "true",
  }

  spec.add_runtime_dependency "activesupport", "~> 6.0"
  spec.add_runtime_dependency "colorize", "~> 0.8"
  spec.add_runtime_dependency "dinja", "~> 2.0"
  spec.add_runtime_dependency "dotenv", "~> 2.7"
  spec.add_runtime_dependency "git", "~> 1.9"
  spec.add_runtime_dependency "zeitwerk", "~> 2.4"

  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-performance"
  spec.add_development_dependency "rubocop-rake"
  spec.add_development_dependency "rubocop-rspec"

  spec.add_development_dependency "climate_control"
  spec.add_development_dependency "factory_bot"
  spec.add_development_dependency "fakefs"
  spec.add_development_dependency "ffaker"
  spec.add_development_dependency "overcommit"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.10"
  spec.add_development_dependency "shoulda-matchers"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "super_diff"
  spec.add_development_dependency "timecop"
  spec.add_development_dependency "webmock"

  spec.add_development_dependency "jekyll"
end
