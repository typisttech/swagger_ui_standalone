# frozen_string_literal: true

require_relative "lib/swagger_ui_standalone/version"

Gem::Specification.new do |spec|
  spec.name = "swagger_ui_standalone"
  spec.version = SwaggerUIStandalone::VERSION
  spec.authors = ["Typist Tech Limited", "Tang Rufus"]
  spec.email = ["opensource+swagger_ui_standalone@typist.tech", "tangrufus@gmail.com"]

  spec.summary = "Generate standalone static Swagger UI sites from OpenAPI specifications."
  spec.homepage = "https://github.com/typisttech/swagger_ui_standalone"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/releases"
  spec.metadata["bug_tracker_uri"] = "#{spec.homepage}/issues"
  spec.metadata["funding_uri"] = "https://github.com/sponsors/tangrufus"

  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "octokit", "~> 10.0"
  spec.add_dependency "faraday-retry", "~> 2.3" # For octokit

  spec.add_dependency "down", "~> 5.4"
  spec.add_dependency "rubyzip", "~> 2.4"

  spec.add_dependency "thor", "~> 1.3"
end
