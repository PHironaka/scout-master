class StaticPagesController < ApplicationController

  def home

  end

  def help
  end

  def about
    if logged_in?
      redirect_to locations_path
    end
  end

  def terms
  end

end
