require 'phantomjs_helper'

class UsersTest < Faktory::PhantomJSTestCase
  def test_home
    PageObjects::Faktory::HomePage.visit
    Ojo.screenshot(branch_name, __method__)
  end

  def test_sign_in__form
    user = create(:user)

    home_page = PageObjects::Faktory::HomePage.visit

    sign_in_page = home_page.navigation.sign_in!
    sign_in_page.user_email.set user.email
    sign_in_page.user_password.set user.password
    home_page = sign_in_page.sign_in!

    Ojo.screenshot(branch_name, 'signed_in')

    users_page = home_page.navigation.users!
    Ojo.screenshot(branch_name, 'user')

    assert page.has_content?(user.name)

    home_page = users_page.navigation.home!
    assert_equal '/', page.current_path

    home_page.navigation.current_user!
    assert page.has_content?(user.name)

    Ojo.screenshot(branch_name, 'current_user')
  end
end
