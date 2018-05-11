# The `.rspec` file also contains a few flags that are not defaults but that users commonly want.
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  require_relative '../lib/naive_coin'
  require 'active_support'
  require 'active_support/core_ext/numeric'
  require 'factories'
  require 'timecop'
  require 'pry'

  config.include Factory

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.order = :random
end
