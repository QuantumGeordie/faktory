require 'test_helper'

require 'capybara/dsl'
require 'capybara/rails'

## PhantomJS driver
# require 'capybara/poltergeist'

# Capybara.default_driver = :poltergeist
# Capybara.javascript_driver = :poltergeist

## same tests can be run with selenium instead of phantomjs/poltergeist
require 'selenium-webdriver'

Capybara.default_driver = :selenium
Capybara.javascript_driver = :selenium

require 'page_objects'

module Faktory
  class PhantomJSTestCase < ActiveSupport::TestCase
    include Capybara::DSL

    def setup
      Ojo.screenshotter = lambda do |filename|
        FileUtils.mkdir_p(File.dirname(filename))
        page.save_screenshot(filename)
      end
      Capybara.reset!
    end

    def teardown
      Capybara.reset!
    end

    private

    def branch_name
      `git rev-parse --abbrev-ref HEAD`.chomp || 'XXXXXX'
    end
  end
end
