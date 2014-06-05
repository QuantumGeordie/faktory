require 'selenium_helper'

class HomeTest < Faktory::SeleniumTestCase

  def test_visit_home_page
    page_text = 'Welcome to The Faktory. Expect great things. - Geordie'

    PageObjects::Faktory::HomePage.visit

    assert page.has_content?(page_text)

    if RUN_KRACKER_TESTS
      res, msg = page_map_same?('home')
      assert res, msg
    end
  end

end