ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

module Fackory
  class ActiveSupport::TestCase

    include FactoryGirl::Syntax::Methods
    include Warden::Test::Helpers

    I18n.enforce_available_locales = false
    self.fixture_path = "#{::Rails.root}/test/fixtures"
    self.use_transactional_fixtures = false
    self.use_instantiated_fixtures = true

    Warden.test_mode!

    # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
    #
    # Note: You'll currently still have to declare fixtures explicitly in integration tests
    # -- they do not yet inherit this setting
    fixtures :all

  end
end
