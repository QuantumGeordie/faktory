require 'test_helper'
require 'rails/performance_test_help'

class UsersPerformanceTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  self.profile_options = { :runs => 5, :metrics => [:wall_time, :memory],
                            :output => 'tmp/performance', :formats => [:flat] }

  include Warden::Test::Helpers

  def test_users_index
    user = create(:user)
    login_as(user)

    get '/users'
  end
end
