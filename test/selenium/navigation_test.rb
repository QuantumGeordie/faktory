require 'selenium_helper'

class NavigationTest < Faktory::SeleniumTestCase

  def test_visit_locations
    page_text = 'Welcome to The Faktory. Expect great things. - Geordie'

    home_page = PageObjects::Faktory::HomePage.visit
    assert page.has_content?(page_text)

    sleep 1

    users_page = home_page.navigation.users!
    assert page.has_content?(page_text)

    sleep 1

    lines_page = users_page.navigation.lines!
    assert page.has_content?(page_text)

    sleep 1

    rework_page = lines_page.navigation.rework!
    assert page.has_content?(page_text)

    sleep 1
    home_page = rework_page.navigation.home!
    assert page.has_content?(page_text)

    sleep 1
  end

end