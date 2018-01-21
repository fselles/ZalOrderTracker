class UsersController < ApplicationController
  before_action :require_signin
  before_action :require_admin, only: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "Gebruiker aangemaakt!"
    else
      flash.now[:alert] = "Er zijn fouten bij het aanmaken van de gebruiker!"
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Account succesvol opgeslagen!"
    else
      flash.now[:alert] = "Er zijn fouten bij het updaten van de gebruiker!"
      render :edit
    end
  end

  def destroy
    @user.destroy
    if current_user && current_user.admin?
      redirect_to users_path
      else
      session[:user_id] = nil
      redirect_to root_url, notice: "Account succesvol verwijderd!"
    end
  end

  private

  def user_params
    params.require(:user).
      permit(:name, :email, :company, :password, :password_confirmation, :admin)
  end


    def require_correct_user
      @user = User.find(params[:id])
        redirect_to root_url, alert: "Niet toegestaan!" unless current_user?(@user) || current_user.admin?
  end
end
