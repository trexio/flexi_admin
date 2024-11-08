# frozen_string_literal: true

require_relative "lib/jaaf/version"

Gem::Specification.new do |spec|
  spec.name = "jaaf"
  spec.version = Jaaf::VERSION
  spec.authors = ["Tomas Landovsky"]
  spec.email = ["landovsky@gmail.com"]

  spec.summary = "Just Another Admin Framework"
  spec.description = "Just Another Admin Framework"
  spec.homepage = "https://github.com/landovsky/jaaf"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/landovsky/jaaf"
  spec.metadata["changelog_uri"] = "https://github.com/landovsky/jaaf/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile .DS_Store])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib", "lib/jaaf", "lib/jaaf/components",
                        "lib/jaaf/models", "lib/jaaf/controllers",
                        "lib/jaaf/views", "lib/jaaf/assets",
                        "lib/jaaf/helpers", "lib/jaaf/services",
                        "lib/jaaf/javascript"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "rails", "~> 7.1.0"
  spec.add_dependency "slim-rails"
  spec.add_dependency "view_component", "~> 3.1.0"

  # Development dependencies
  spec.add_development_dependency "rspec-rails", "~> 6.1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
