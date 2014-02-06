module PageObjects
  module Faktory
    module Users
      class UsersSignInPage < FaktoryPage
        path '/users/sign_in'

        element :user_email
        element :user_password

        def sign_in!
          node.click_button('Sign in')
        end
      end
    end
  end
end