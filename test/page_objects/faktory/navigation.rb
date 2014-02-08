module PageObjects
  module Faktory
    class Navigation < ::AePageObjects::Element

      def home!
        node.find('nav li.name a').click
        PageObjects::Faktory::HomePage.new
      end

      def users!(expect_success = true)
        node.find_link('users').click
        PageObjects::Faktory::Users::UsersPage.new if expect_success
      end

      def sign_in!
        node.find_link('sign in').click
        PageObjects::Faktory::Users::UsersSignInPage.new
      end

      def register!
        node.find_link('register').click
        PageObjects::Faktory::Users::UsersSignUpPage.new
      end

      def logout
        node.find_link('logout').click
      end

      def current_user!
        node.find("#js-current_user").click
        PageObjects::Faktory::Users::UserPage.new
      end

    end
  end
end


