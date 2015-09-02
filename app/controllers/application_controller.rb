class ApplicationController < ActionController::Base
  layout 'application'
  protect_from_forgery

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name


  end
end






