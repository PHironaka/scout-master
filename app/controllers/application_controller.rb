class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :authorize

  def title(page_title)
    content_for(:title) { page_title }
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def authorize
    # flash[:alert] = "You mush be logged in." and redirect_to root_path unless logged_in?

    # If you're not logged in, a flash alert saying 'you must be logged in and redirect to the root index'
    if !logged_in?
      flash[:alert] = "You mush be logged in."
      redirect_to root_path
    end

  end
end
