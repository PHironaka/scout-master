Rails.application.routes.draw do
  get 'static_pages/home'

  get 'static_pages/help'

  root 'locations#index'
  resources :users

  resources :locations do
    resources :comments

    member do
      put "like" => "locations#upvote"
      put "dislike" => "locations#downvote"
    end
  end


#   Prefix Verb   URI Pattern               Controller#Action
#   root GET    /                         users#index
#  users GET    /users(.:format)          users#index
#        POST   /users(.:format)          users#create
# new_user GET    /users/new(.:format)      users#new
# edit_user GET    /users/:id/edit(.:format) users#edit
#   user GET    /users/:id(.:format)      users#show
#        PATCH  /users/:id(.:format)      users#update
#        PUT    /users/:id(.:format)      users#update
#        DELETE /users/:id(.:format)      users#destroy

delete '/logout' => 'sessions#destroy', as: :logout
resources :sessions, only: [:new, :create]



end
