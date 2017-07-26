class LocationsController < ApplicationController

  #before you log in, you're only authorized to see the index and show
  before_action :authorize, except: [:index, :show]
  before_action :set_location, only: [:show, :edit, :update, :destroy, :upvote, :downvote ]

  def index

    if params[:query].present?
         @locations = Location.search(params[:query], page: params[:page])
       else
         @locations = Location.all.page params[:page]
       end

       if params[:search]
@locations = Location.search(params[:search]).order("created_at DESC")
   else
  @locations = Location.all.order('created_at DESC')
  end


    if params[:tag]
    @locations = Location.all.tagged_with(params[:tag]).order("created_at DESC").paginate(:page => params[:page], :per_page => 4)
  else
    @locations = Location.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 4)
  end

    # @locations = Location.all.order(:cached_votes_up => :desc)

    @locations = @locations.paginate(:page => params[:page], :per_page => 4)

    @hash = Gmaps4rails.build_markers(@locations) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
      marker.infowindow location.title
      marker.picture({
                 :url => "https://maxcdn.icons8.com/Color/PNG/48/Maps/user_location-48.png",
                 :width   => 48,
                 :height  => 48
                })
      marker.infowindow "
      <h4><a href='/locations/#{location.friendly_id}'>
      #{location.title} </a></h4>
      <p> #{location.address} </p> "
    end
  end

  def show
    # @location = Location.find(params[:id])
    # @location = Location.friendly.find(params[:id])
    @comments = Comment.where(location_id: @location).order("created_at DESC")
    set_meta_tags reverse: :true,
                  description: @location.title
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
    # @location = Location.friendly.find(params[:id])
  end

  def update
    # @location = Location.friendly.find(params[:id])

    # using the WHITE-LISTED params from the edit form (feeling, and body) only, try to update the existing blurb. If it succeeds, take the user to the blurb show view:
    if  @location.update_attributes(location_params)
      redirect_to location_path(@location)
    else
    # otherwise, take the user to the edit view again, so they can retry the update:
      redirect_to edit_location_path(@location)
    end
  end

  def destroy
    # @location = Location.friendly.find params[:id]
    @location.destroy
    redirect_to locations_path
  end

  def upvote
      # @location = Location.friendly.find(params[:id])
    current_user.upvotes @location
    respond_to do |format|
    format.html {redirect_to :back }
    end
  end

  def downvote
    current_user.downvotes @location
  end

  private

  def set_location
    @location = Location.friendly.find(params[:id])
  end

    def location_params
      params.require(:location).permit(:latitude, :longitude,:address, :title, :tag_list, :body, :search, :image, :slug)
    end

end
