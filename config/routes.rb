Rails.application.routes.draw do
  root 'locations#index'
  get 'errors/not_found'
  get 'errors/internal_server_error'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'tags/:tag', to:  'locations#index', as: :tag
  get '/help' => 'static_pages#help'
  get '/about' => 'static_pages#about'
  get    '/login' => 'sessions#new'
  get    '/contact' => 'static_pages#contact'
  get    '/terms' => 'static_pages#terms'
  get '/locations' => 'locations#index'

  resources :locations do
    resources :photos
    resources :comments
        member do
          put "like" => "locations#upvote"
          put "dislike" => "locations#downvote"
        end
  end

  resources :password_resets,     only: [:new, :create, :edit, :update]


  delete '/logout' => 'sessions#destroy', as: :logout
  resources :sessions, only: [:new, :create]
  resources :users do
    member do
      get :confirm_email
      get :follow
      get :unfollow
      end
    end

  get "*any", via: :all, to: "errors#not_found"


end
