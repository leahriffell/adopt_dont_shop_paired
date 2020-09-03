class UsersController < ApplicationController
  def sign_up
  end

  def create 
    new_user = User.create(user_params)
    welcome_message
    session[:user_id] = new_user.id
    redirect_to "/"
  end

  def show 
  end

  private 

  def user_params
    params.permit(:username, :password)
  end

  def welcome_message
    flash[:success] = "Welcome, #{user_params[:username]}!"
  end
end
