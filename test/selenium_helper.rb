require 'test_helper'

require 'capybara'
require 'capybara/dsl'
require 'capybara/rails'
require 'selenium-webdriver'

require 'page_objects'

require 'kracker'

RUN_KRACKER_TESTS = false

if ENV["SAUCE"]
  require 'sauce'
  require 'sauce/capybara'
  require 'sauce/connect'

  Capybara.run_server = true
  Capybara.server_port = 3333
  ENV['APP_SERVER_PORT'] = Capybara.server_port.to_s

  Sauce.config do |config|
    config[:application_port] = ENV['APP_SERVER_PORT']
    config[:start_local_application] = false
    config[:start_tunnel]            = false

    config[:application_host]        = "localhost"
    config[:username]                = ENV['SAUCE_USERNAME']
    config[:access_key]              = ENV['SAUCE_ACCESS_KEY']
    config[:tags]                    = [ rand(36**8).to_s(36),       # fake run id to keep tests straight in saucelabs list
                                         `whoami`.chomp,
                                         `git rev-parse --abbrev-ref HEAD`.chomp ]

    config[:browsers] = [
                          ['OS X 10.8', 'iphone', '6.1'],
                          ['OS X 10.8', 'iphone', '6.1'],
                          ['Windows 8.1', 'Internet Explorer', '11'],
                          ['Windows 8.1', 'firefox', '29']
                        ]
  end

  Capybara.default_wait_time = 30
  Capybara.default_driver    = :sauce
  Capybara.javascript_driver = :sauce

  module Faktory
    class SeleniumTestCase < Sauce::RailsTestCase
      include FactoryGirl::Syntax::Methods
      I18n.enforce_available_locales = false
      self.fixture_path = "#{::Rails.root}/test/fixtures"
      self.use_transactional_fixtures = false
      self.use_instantiated_fixtures = true
      fixtures :all
      include Capybara::DSL

      def setup

      end

      def teardown
        logout
      end
    end
  end
elsif ENV["BSTACK"]
  bstack_username = ENV['BSTACK_USERNAME']
  bstack_access_key = ENV['BSTACK_ACCESS_KEY']

  url = rl = "http://#{bstack_username}:#{bstack_access_key}@hub.browserstack.com/wd/hub"
  caps = Selenium::WebDriver::Remote::Capabilities.new
  caps['browserstack.debug'] = 'true'
  caps['browserstack.tunnel'] = 'true'
  caps['browserstack.local'] = 'true'
  caps["browser"] = "IE"
  caps["browser_version"] = "7.0"
  caps["os"] = "Windows"
  caps["os_version"] = "XP"
  caps["name"] = "Testing Selenium 2 with Ruby on BrowserStack"


  Capybara.register_driver :bstack_browser do |app|
    Capybara::Selenium::Driver.new(app, :browser => :remote, :url => url, :desired_capabilities => caps)
  end

  Capybara.default_driver = :bstack_browser

  module Faktory
    class SeleniumTestCase < ActiveSupport::TestCase
      include Capybara::DSL

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

    def teardown
      capture_artifacts unless passed?
    end

    def capture_artifacts
      filename = File.join(screenshot_path, "#{send(:__name__)}.png")
      page.driver.browser.save_screenshot(filename)
    end

  end
end

def screenshot_path
  File.join(::Rails.root, 'tmp', 'screenshots')
end

FileUtils.rm_rf screenshot_path
FileUtils.mkdir_p screenshot_path

def resize_browser(width, height)
  page.driver.browser.manage.window.resize_to(width, height)
end

def size_browser(dimensions)
  page.driver.browser.manage.window.size = dimensions
end

def get_current_browser_dimensions
  page.driver.browser.manage.window.size
end




