class UsersController < ApplicationController
  def new
  end

  def create 
    User.create(user_params)
    welcome_message
    redirect_to "/"
  end

  private 

  def user_params
    params.permit(:username, :password)
  end

  def welcome_message
    flash[:success] = "Welcome, #{user_params[:username]}!"
  end
end
