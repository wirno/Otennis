class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up) do |user_params|
    	user_params.permit(:nom, :prenom, :email, :password, :password_confirmation, :age, :ville, :cp, :genre)
    end

      	devise_parameter_sanitizer.permit(:account_update) do |user_params|
    	user_params.permit(:nom, :prenom, :age, :genre, :cp, :ville, :tennislevel, :anneetennis, :avatar, :email, :password)
    end

  end
end
