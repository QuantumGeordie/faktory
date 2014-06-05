require 'selenium_helper'

class UsersTest < Faktory::SeleniumTestCase

  def test_users_index__not_logged_in
    home_page = PageObjects::Faktory::HomePage.visit

    home_page.navigation.users! false
    assert_equal '/users/sign_in', page.current_path, 'should be on the sign in page after trying to visit users when not logged in.'
  end

  def test_sign_in__form
    user = create(:user)

    home_page = PageObjects::Faktory::HomePage.visit

    sign_in_page = home_page.navigation.sign_in!
    sign_in_page.user_email.set user.email
    sign_in_page.user_password.set user.password
    sign_in_page.sign_in!

    home_page = PageObjects::Faktory::HomePage.new

    users_page = home_page.navigation.users!
    assert page.has_content?(user.name)

    home_page = users_page.navigation.home!
    assert_equal '/', page.current_path

    home_page.navigation.current_user!
    assert page.has_content?(user.name)
  end

  def test_sign_up
    home_page = PageObjects::Faktory::HomePage.visit

    sign_up_page = home_page.navigation.register!
    sign_up_page.user_name.set 'Kenny Dalglish'
    sign_up_page.user_email.set 'king_kenny@lfc.com'
    sign_up_page.user_password.set 'looprevil'
    sign_up_page.user_password_confirmation.set 'looprevil'

    ## good example of where this test does not work. locally, all is ok. on travis, input button looks different (Mac vs. Linux?)
    ## and fails due to the different sizes of button. maybe a good reason for the test because the rendered button does look
    ## a bunch different.
    #page_same, msg = page_map_same?('sign_up')
    #assert page_same, msg

    sign_up_page.sign_up!

    assert page.has_content?('Welcome! You have signed up successfully.')

    user = User.last

    home_page = PageObjects::Faktory::HomePage.new
    home_page.navigation.toggle_menu
    displayed_username = home_page.navigation.current_user_name.text
    assert_equal user.name, displayed_username, 'The current user displayed'

    assert_equal "/", page.current_path, 'should end up on homepage'

  end

  def test_logout
    user = create(:user)
    login_as(user, :scope => :user)

    home_page = PageObjects::Faktory::HomePage.visit
    home_page.navigation.toggle_menu
    assert page.has_content?(user.name), 'user should be logged in now'
    logged_in_page_same, logged_in_msg = page_map_same?('logged_in') if RUN_KRACKER_TESTS

    home_page.navigation.toggle_menu

    home_page.navigation.logout
    assert page.has_content?('Signed out successfully.')

    logged_out_page_same, logged_out_msg = page_map_same?('logged_out') if RUN_KRACKER_TESTS

    if RUN_KRACKER_TESTS
      assert logged_in_page_same,  logged_in_msg
      assert logged_out_page_same, logged_out_msg
    end
  end

end