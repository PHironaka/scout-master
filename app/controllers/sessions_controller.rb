class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      if @user.email_confirmed
        session[:user_id] = @user.id
        redirect_to root_path
      else
        flash[:error] = 'Please activate your account.'
        redirect_to new_session_path
      end
    else
      redirect_to root_path, flash: "Username or Password was wrong"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
