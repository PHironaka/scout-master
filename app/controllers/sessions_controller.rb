class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      flash[:success] = "Welcome to the Sample App!"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:error] = 'Please activate your account.' # Not quite right!
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
