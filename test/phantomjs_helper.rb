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

    private

    def screenshot_path
      File.join(Rails.root, 'tmp', 'screenshots')
    end

    def screenshot_file(name)
      File.join(screenshot_path, branch_name, "#{name}.png")
    end

    def appearance_diff_path
      File.join(screenshot_path, 'diff')
    end

    def branch_name
      `git rev-parse --abbrev-ref HEAD`.chomp || 'XXXXXX'
    end
  end
end

if ENV['THIS_BRANCH']
  `git checkout #{ENV['THIS_BRANCH']}`
  current_branch = `git rev-parse --abbrev-ref HEAD`.chomp
  raise 'wrong branch' unless current_branch == ENV['THIS_BRANCH']
end
