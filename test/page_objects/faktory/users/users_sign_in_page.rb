module PageObjects
  module Faktory
    module Users
      class UsersSignInPage < FaktoryPage
        path :new_user_session

        element :user_email
        element :user_password

        def sign_in!
          node.click_button('Log in')
          PageObjects::Faktory::HomePage.new
        end
      end
    end
  end
end
