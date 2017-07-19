class SearchController < ApplicationController
  def search
  if params[:q].nil?
    @locations = []
  else
    @locations = Location.search params[:q]
  end
end

end
