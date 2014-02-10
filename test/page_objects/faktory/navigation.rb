module PageObjects
  module Faktory
    class Navigation < ::AePageObjects::Element

      element :current_user_name, :locator => '#js-current_user'

      def toggle_menu
        menu_toggles = node.all('nav li.toggle-topbar')
        if menu_toggles.count > 0
          menu_toggles.first.click
          sleep 0.2
        end
      end

      def home!
        toggle_menu
        node.find('nav li.name a').click
        PageObjects::Faktory::HomePage.new
      end

      def users!(expect_success = true)
        toggle_menu
        node.find_link('users').click
        PageObjects::Faktory::Users::UsersPage.new if expect_success
      end

      def sign_in!
        toggle_menu
        node.find_link('sign in').click
        PageObjects::Faktory::Users::UsersSignInPage.new
      end

      def register!
        toggle_menu
        node.find_link('register').click
        PageObjects::Faktory::Users::UsersSignUpPage.new
      end

      def logout
        toggle_menu
        node.find_link('logout').click
      end

      def current_user!
        toggle_menu
        node.find("#js-current_user").click
        PageObjects::Faktory::Users::UserPage.new
      end

    end
  end
end


