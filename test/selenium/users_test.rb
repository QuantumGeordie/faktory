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

    users_page.navigation.home!
    assert_equal '/', page.current_path
  end

  def test_sign_up
    home_page = PageObjects::Faktory::HomePage.visit

    sign_up_page = home_page.navigation.register!
    sign_up_page.user_name.set 'Kenny Dalglish'
    sign_up_page.user_email.set 'king_kenny@lfc.com'
    sign_up_page.user_password.set 'looprevil'
    sign_up_page.user_password_confirmation.set 'looprevil'
    sign_up_page.sign_up!

    assert page.has_content?('Welcome! You have signed up successfully.')
    assert page.has_content?('Kenny Dalglish')
    assert_equal "/", page.current_path, 'should end up on homepage'
  end

  def test_logout
    user = create(:user)
    login_as(user, :scope => :user)

    home_page = PageObjects::Faktory::HomePage.visit
    assert page.has_content?(user.name), 'user should be logged in now'

    home_page.navigation.logout
    assert page.has_content?('Signed out successfully.')
  end

end