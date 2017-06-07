class CommentsController < ApplicationController
  before_action :find_location
  before_action :find_comment, only: [:destroy, :edit, :update, :comment_owner]
  before_action :comment_owner, only: [:destroy, :edit, :update]

  def create
    @comment = @location.comments.create(params[:comment].permit(:content))
    @comment.user_id = current_user.id
    @comment.save

    if @comment.save
      redirect_to location_path(@location)
    else
      render 'new'
    end
  end

  def destroy
    @comment.destroy
    redirect_to location_path(@location)
  end

  def edit
  end

  def update
    if @comment.update(params[:comment].permit(:content))
      redirect_to location_path(@location)
    else
      render 'edit'
    end
  end

  private

  def find_location
    @location = Location.friendly.find(params[:location_id])
  end

  def find_comment
    @comment = @location.comments.find(params[:id])
  end

  def comment_owner
    unless @comment.user_id = current_user.id
        flash[:notice] = "You are not allowed here!"
        redirect_to @location
    end
  end

end
