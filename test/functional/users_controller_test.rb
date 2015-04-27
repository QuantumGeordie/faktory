require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "should get index" do
    user = create(:user)
    sign_in(user)

    get :index
    assert_response :success
  end

  test 'should get json list of users' do
    user = create(:user)
    sign_in(user)

    get :index, {:format => 'json'}

    assert_response :success

    json_response_as_hash = JSON.parse(@response.body)

    assert_equal 1, json_response_as_hash.count

    user_1 = json_response_as_hash.first

    assert_equal user.id,    user_1['id']
    assert_equal user.email, user_1['email']
    assert_equal user.name,  user_1['name']
  end

  test "should get show" do
    user = create(:user)
    sign_in(user)

    get :show, :id => user.id
    assert_response :success
    assert_match user.name, @response.body
  end

end
