require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "should get index" do
    user = create(:user)
    sign_in(user)

    get :index
    assert_response :success
  end

  test "should get show" do
    user = create(:user)
    sign_in(user)

    get :show, :id => user.id
    assert_response :success
    assert_match user.name, @response.body
  end

end
