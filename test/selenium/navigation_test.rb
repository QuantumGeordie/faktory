require 'selenium_helper'

class NavigationTest < Faktory::SeleniumTestCase


  def test_navigation__not_logged_in

    page_text = 'Welcome to The Faktory. Expect great things. - Geordie'

    home_page = PageObjects::Faktory::HomePage.visit
    assert page.has_content?(page_text)

    home_page.navigation.users! false
    assert_match 'sign_in', page.current_path

    #PageObjects::Faktory::Users::UsersSignInPage.new.navigation.lines! false
    #assert_match 'sign_in', page.current_path
    #
    #PageObjects::Faktory::Users::UsersSignInPage.new.navigation.rework! false
    #assert_match 'sign_in', page.current_path
  end

  def test_visit_locations
    user = create(:user)
    page_text = 'Welcome to The Faktory. Expect great things. - Geordie'

    home_page = PageObjects::Faktory::HomePage.visit
    assert page.has_content?(page_text)

    sign_in_page = home_page.navigation.sign_in!
    sign_in_page.user_email.set user.email
    sign_in_page.user_password.set user.password
    sign_in_page.sign_in!

    puts "current_path: #{page.current_path}"

    home_page = PageObjects::Faktory::HomePage.new

    users_page = home_page.navigation.users!
    assert page.has_content?(user.name)

    #sleep 1
    #
    #lines_page = users_page.navigation.lines!
    #assert page.has_content?(page_text)
    #
    #sleep 1
    #
    #rework_page = lines_page.navigation.rework!
    #assert page.has_content?(page_text)

    sleep 1
    home_page = users_page.navigation.home!
    assert page.has_content?(page_text)

    sleep 1
  end

  private


end