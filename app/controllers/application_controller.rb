class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up) do |user_params|
    	user_params.permit(:avatar, :nom, :prenom, :age, :cp, :ville, :tennislevel, :anneetennis, :pseudo, :email, :password, :password_confirmation, :genre)
    end

    devise_parameter_sanitizer.permit(:account_update) do |user_params|
    	user_params.permit(:nom, :prenom, :age, :cp, :ville, :tennislevel, :anneetennis, :pseudo, :avatar, :email, :password, :password_confirmation, :genre)
    end

  end
end
