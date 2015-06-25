require 'selenium_helper'
require 'webmock/minitest'

require_relative '../fakes'

WebMock.disable_net_connect!(allow_localhost: true)

class BlankApiTest < Faktory::SeleniumTestCase
  include Fakes

  setup :setup_fake_app

  def test_blank_app_api
    blank_app_api_page = PageObjects::Faktory::BlankAppApi::BlankAppApiPage.visit
    assert_equal "{\"key\" : \"geordie\", \"value\" : \"count_1\"}", blank_app_api_page.results.text, 'the results from the the blank app api'

    # see /test/functional/welcome_controller_test.rb for other ways to configure and use the fake app in a test.
  end

  private

  def setup_fake_app
    @fake_blank = FakeBlank.new
    stub_request(:any, /localhost:9292/).to_rack(@fake_blank)
  end
end
