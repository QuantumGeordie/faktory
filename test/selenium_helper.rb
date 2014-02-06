require 'test_helper'

require 'capybara'
require 'capybara/dsl'
require 'capybara/rails'
require 'selenium-webdriver'

require 'page_objects'

Capybara.default_driver = :selenium

module Faktory
  class SeleniumTestCase < ActiveSupport::TestCase
    include Capybara::DSL

    def teardown
      logout
    end

  end
end
