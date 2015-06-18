require 'test_helper'
require 'webmock/minitest'

require_relative '../fakes'

WebMock.disable_net_connect!(allow_localhost: false)

class WelcomeControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  include Fakes

  test "should get index" do
    get :index
    assert_response :success
  end

  test 'should get blank_ap results' do
    FakeBlank.set_counter(100)

    fake_blank = FakeBlank.new

    stub_request(:any, /localhost:9292/).to_rack(fake_blank)

    get :blank_app
    assert_match 'geordie', @response.body
    assert_match 'count_101', @response.body
    assert_response :success

    FakeBlank.set_counter(200)

    get :blank_app
    assert_match 'geordie', @response.body
    assert_match 'count_201', @response.body
    refute_match 'use the magic', @response.body
    assert_response :success

    fake_blank.instance_variable_get(:@instance).magic_instance_method        ## gotta do this cuz FakeBlank.new returns a Sinatra::Wrapper that hides the guts.
    get :blank_app
    assert_match 'geordie', @response.body
    assert_match 'count_202', @response.body
    assert_match 'use the magic', @response.body
    assert_response :success
  end
end
