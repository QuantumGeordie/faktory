require 'test_helper'
require 'webmock/minitest'

require_relative '../fakes'

WebMock.disable_net_connect!(allow_localhost: false)

class WelcomeControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  include Fakes

  setup :prepare_flake_app_state

  test "should get index" do
    get :index
    assert_response :success
  end

  test 'should get blank_app results' do
    FakeBlank.set_counter(100)

    get :blank_app
    assert_response :success
    assert_match 'geordie', @response.body
    assert_match 'count_101', @response.body

    FakeBlank.set_counter(200)

    get :blank_app
    assert_response :success
    assert_match 'geordie', @response.body
    assert_match 'count_201', @response.body
    refute_match 'use the magic', @response.body

    @fake_blank.instance_variable_get(:@instance).magic_instance_method        ## gotta do this cuz FakeBlank.new returns a Sinatra::Wrapper that hides the guts.
    get :blank_app
    assert_response :success
    assert_match 'geordie', @response.body
    assert_match 'count_202', @response.body
    assert_match 'use the magic', @response.body
  end

  test 'should be able to modify blank_app status code' do
    set_fake_status_code(404)
    get :blank_app
    assert_response :success    # the page in this app will return success because the 404 from the third party (blank app) was handled properly in this app (faktory)
    assert_match '404 Resource Not Found:', @response.body
  end

  test 'should be able to modify blank_app key and value' do
    # standard response without setting anything
    get :blank_app
    assert_response :success
    assert_match 'geordie', @response.body
    assert_match 'count_1', @response.body

    # change the key and value of response
    set_fake_key('liverpool_fc')
    set_fake_value('the_best')
    get :blank_app
    assert_response :success
    assert_match 'liverpool_fc', @response.body
    assert_match 'the_best', @response.body
  end

  private

  def prepare_flake_app_state
    @fake_blank = FakeBlank.new
    stub_request(:any, /localhost:9292/).to_rack(@fake_blank)
    reset_fake_app_state
  end

  def reset_fake_app_state
    send_something 'http://localhost:9292/config/reset/'
  end

  def set_fake_key(key)
    send_something "http://localhost:9292/config/set_key/#{key}"
  end

  def set_fake_value(value)
    send_something "http://localhost:9292/config/set_value/#{value}"
  end

  def set_fake_status_code(code)
    send_something "http://localhost:9292/config/set_status/#{code}"
  end

  def send_something(str)
    begin
      RestClient.get(str, {"X-Requested-With" => "XMLHttpRequest"}).to_s
    rescue => e
      e.to_s
    end
  end
end
