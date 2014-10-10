require 'phantomjs_helper'

class UsersTest < Faktory::PhantomJSTestCase
  def test_home
    PageObjects::Faktory::HomePage.visit
    screenshot_filename = screenshot_file(__method__)
    page.save_screenshot(screenshot_filename)
  end

  def test_sign_in__form
    user = create(:user)

    home_page = PageObjects::Faktory::HomePage.visit

    sign_in_page = home_page.navigation.sign_in!
    sign_in_page.user_email.set user.email
    sign_in_page.user_password.set user.password
    sign_in_page.sign_in!

    page.save_screenshot(screenshot_file('signed_in'))
    home_page = PageObjects::Faktory::HomePage.new

    users_page = home_page.navigation.users!
    page.save_screenshot(screenshot_file('users'))

    assert page.has_content?(user.name)

    home_page = users_page.navigation.home!
    assert_equal '/', page.current_path

    home_page.navigation.current_user!
    assert page.has_content?(user.name)

    page.save_screenshot(screenshot_file('current_user'))
  end
end
