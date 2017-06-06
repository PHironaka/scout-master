class UsersController < ApplicationController
  before_action :authorize, only: [:show]

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
    params.require(:user).permit(:name, :email, :summary, :portfolio, :hometown,:socialtwo, :instagram,  :password, :avatar, :slug)
  end
end
