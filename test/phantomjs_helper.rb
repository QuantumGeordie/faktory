require 'test_helper'

require 'capybara/dsl'
require 'capybara/rails'
require 'capybara/poltergeist'

require 'page_objects'

Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist

module Faktory
  class PhantomJSTestCase < ActiveSupport::TestCase
    include Capybara::DSL

    def setup
      Capybara.reset!
    end

    def teardown
      Capybara.reset!
    end
  end
end

`git checkout #{ENV['THIS_BRANCH']}`
current_branch = `git rev-parse --abbrev-ref HEAD`.chomp
raise 'wrong branch' unless current_branch == ENV['THIS_BRANCH']
