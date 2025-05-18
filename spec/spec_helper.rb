# frozen_string_literal: true

require "swagger_ui_standalone"
require "swagger_ui_standalone/cli"

require_relative "support/eq_dir"
require_relative "support/eq_zip"
require_relative "support/file_fixture"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
