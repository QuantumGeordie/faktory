require 'test_helper'

require 'capybara'
require 'capybara/dsl'
require 'capybara/rails'
require 'selenium-webdriver'

require 'page_objects'

require 'kracker'

if ENV["SAUCE"]
  require 'sauce'
  require 'sauce/capybara'
  require 'sauce/connect'

  Sauce.config do |config|
    config[:start_local_application] = true
    config[:start_tunnel] = false
    config[:username]   = ENV['SAUCE_USERNAME']
    config[:access_key] = ENV['SAUCE_ACCESS_KEY']
    config[:name] = 'faktory'
    config[:browsers] = [
        ['OS X 10.9', 'iPhone', '7'],
        ['Linux', 'Android', '4.0']
    ]

    config[:application_host] = "localhost"
    config[:local_application_port] = 3000
  end

  Capybara.default_driver = :sauce
  Capybara.server_port = 7070

  module Faktory
    class SeleniumTestCase < Sauce::RailsTestCase
      include FactoryGirl::Syntax::Methods
      I18n.enforce_available_locales = false
      self.fixture_path = "#{::Rails.root}/test/fixtures"
      self.use_transactional_fixtures = false
      self.use_instantiated_fixtures = true
      fixtures :all
      include Capybara::DSL

      def teardown
        logout
      end
    end
  end
else
  Capybara.default_driver = :selenium
  module Faktory
    class SeleniumTestCase < ActiveSupport::TestCase
      include Capybara::DSL

      def setup
        @browser_dimensions = ENV['BROWSER_SIZE'] || '800x600'
        if @browser_dimensions
          @starting_dimensions = get_current_browser_dimensions
          w = @browser_dimensions.split('x')[0]
          h = @browser_dimensions.split('x')[1]
          resize_browser(w, h)
        end
      end

      def teardown
        if @browser_dimensions
          size_browser(@starting_dimensions)
        end
        logout
      end
    end
  end
end

module Faktory
  class SeleniumTestCase
    include Kracker


  end
end

def resize_browser(width, height)
  page.driver.browser.manage.window.resize_to(width, height)
end

def size_browser(dimensions)
  page.driver.browser.manage.window.size = dimensions
end

def get_current_browser_dimensions
  page.driver.browser.manage.window.size
end




