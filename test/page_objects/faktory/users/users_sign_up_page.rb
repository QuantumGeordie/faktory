module PageObjects
  module Faktory
    module Users
      class UsersSignUpPage < FaktoryPage
        path :new_user_registration

        element :user_name
        element :user_email
        element :user_password
        element :user_password_confirmation

        def sign_up!
          node.click_button('Sign up')
        end
      end
    end
  end
end