ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Disable parallel testing for DuckDB compatibility
    # parallelize(workers: :number_of_processors)

    # Disable fixtures since we're using manual test data for DuckDB compatibility
    # fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
