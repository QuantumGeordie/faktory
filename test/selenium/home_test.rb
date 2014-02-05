require 'selenium_helper'

class HomeTest < Faktory::SeleniumTestCase

  def test_visit_home_page
    PageObjects::Faktory::HomePage.visit

    assert page.has_content?('Welcome#index')
  end

end