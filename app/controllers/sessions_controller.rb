class SessionsController < ApplicationController

  def new
  end


  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welkom terug, #{user.name}!"
      redirect_to root_url
    else
      flash.now[:alert] = "Ongeldige email/wachtwoord combinatie!"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Je bent uitgelogd!"
  end

end
