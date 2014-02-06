FactoryGirl.define do
  factory :user do
    name                  'john doe'
    password              'password'
    password_confirmation 'password'
    sequence(:email) { |n| "john_doe_#{n}@example.com" }
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
end