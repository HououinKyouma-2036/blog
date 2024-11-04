class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    redirect_to root_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:username])
    @user ||= User.new(username: params[:username])

    if params[:username].blank?
      @user.errors.add(:username, "cannot be empty")
      render :new, status: :unprocessable_entity
    elsif @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Logged in successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out successfully!"
  end
end
