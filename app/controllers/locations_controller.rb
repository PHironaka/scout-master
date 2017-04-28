class LocationsController < ApplicationController

  #before you log in, you're only authorized to see the index and show
  before_action :authorize, except: [:index, :show]

  def index
    
    if params[:search]
      @locations = Location.search(params[:search])
    else
      @locations = Location.all.order("created_at DESC")
    end
  end

  def show
    # @location = Location.find(params[:id])
    @location = Location.friendly.find(params[:id])
    @comments = Comment.where(location_id: @location).order("created_at DESC")
  end

  def new
    @location = Location.new

  end

  def create
    #THIS gets run first
    @location = Location.new(location_params)
    #then this gets run
    @location.user = current_user

    #then try to save it
    if @location.save
      redirect_to root_path
    else
      redirect_to new_location_path
    end

  end

  def edit
    @location = Location.friendly.find(params[:id])
  end

  def update
    @location = Location.friendly.find(params[:id])

    # using the WHITE-LISTED params from the edit form (feeling, and body) only, try to update the existing blurb. If it succeeds, take the user to the blurb show view:
    if  @location.update_attributes(location_params)
      redirect_to location_path(@location)
    else
    # otherwise, take the user to the edit view again, so they can retry the update:
      redirect_to edit_location_path(@location)
    end
  end

  def destroy
    @location = Location.friendly.find params[:id]
    @location.destroy
    redirect_to locations_path

  end

  private
    def location_params
      params.require(:location).permit(:title, :body, :image, :slug)
    end

end
