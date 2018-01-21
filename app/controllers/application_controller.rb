class ApplicationController < ActionController::Base

  private

  def require_signin
  unless current_user
    redirect_to new_session_url, alert: "Eerst inloggen alstublieft!"
  end
  end

  def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def current_user?(user)
    current_user == user
  end

  helper_method :current_user?

  def require_admin
    unless current_user_admin?
      redirect_to root_url, alert: "Niet toegestaan!"
    end
  end

  def current_user_admin?
    current_user && current_user.admin?
  end

end
