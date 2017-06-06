class UsersController < ApplicationController
  before_action :authorize, only: [:show]

  def confirm_email
      @user = User.friendly.find_by_confirm_token(params[:id])
      if user_params
        user.email_activate
        flash[:success]= "Welcome to Scout Master! Your account has now been confirmed."
        redirect_to root_url
      else
        flash[:error] = "Error: User does not exist."
        redirect_to root_url
      end
  end

  def index
      @users = User.all
  end

  def show
    @user = User.friendly.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.signup_confirmation(@user).deliver_now
      flash[:success] = "Registration Completed! Please confirm your email address."
      redirect_to root_path
    else
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.friendly.find(params[:id])
  end

  def update
      @user = User.friendly.find(params[:id])

      if  @user.update_attributes(user_params)
        redirect_to user_path(@user)
      else
      # otherwise, take the user to the edit view again, so they can retry the update:
        redirect_to edit_user_path(@user)
      end
  end

  def destroy
    @user = User.friendly.find params[:id]
    @user.destroy
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :email_confirmed,  :summary, :portfolio, :hometown,:socialtwo, :instagram,  :password, :avatar, :slug)
  end
end
