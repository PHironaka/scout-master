class UsersController < ApplicationController
  before_action :authorize, only: [:show, :follow, :unfollow]

  def index
      @users = User.all
      @users = @users.paginate(:page => params[:page], :per_page => 7)

  end

  def show
    @user = User.friendly.find(params[:id])
    # @user.following_users.collect{|u| u.locations}
    # @favoriteLocation = Location.where(user_id: current_user.all_follows all_following.pluck(:id))

    @following = current_user.all_following
    @followposts = @following.each do |f|
        f.friendly_id
      end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver_now
      flash[:success] = "Registration Completed! Please confirm your email address."
      redirect_to root_path
    else
      flash[:error] = "Failure: Something went wrong."
      redirect_to new_user_path
    end
  end

  def confirm_email
      @user = User.friendly.find_by_confirm_token(params[:id])
      if @user
        @user.email_activate
        flash[:success]= "Welcome to Scout Master! Your account has now been confirmed."
        redirect_to root_path
      else
        flash[:error] = "Error: User does not exist."
        redirect_to root_path
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

  def follow
    @user = User.friendly.find(params[:id])
  respond_to do |format|
    if current_user
      if current_user == @user
        format.html { redirect_to current_user, alert: "You can't follow yourself." }
      else
        current_user.follow(@user)
        format.html { redirect_to @user, notice: "You are now following #{@user.name}." }
        format.js
        # RecommenderMailer.new_follower(@user).deliver if @user.notify_new_follower
      end
    else
      format.html { redirect_to root_path, alert: "You must <a href='/users/sign_in'>login</a> to follow #{@user.name}.".html_safe }
    end
   end
  end

def unfollow
  @user = User.friendly.find(params[:id])
  respond_to do |format|
    if current_user
      current_user.stop_following(@user)
      format.html { redirect_to root_path, notice: "You are no longer following #{@user.name}." }
      format.js
    else
      format.html { redirect_to @user, alert: "You must <a href='/users/sign_in'>login</a> to unfollow #{@user.name}.".html_safe }
    end
  end
end

  private
  def user_params
    params.require(:user).permit(:name, :email, :email_confirmed, :voter_id, :summary, :portfolio, :hometown,:socialtwo, :instagram,  :password, :avatar, :slug)
  end
end
