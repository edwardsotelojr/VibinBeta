Rails.application.routes.draw do
  get 'songs/create'
  get 'songs/destroy'
  get 'songs/new'
  get 'songs/edit'
  get 'music/destroy'
  get 'privacy_settings/edit'
  get 'privacy_settings/update'
  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'
  get 'password_resets/new'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  #get 'users/index'

  resources :users do
    member do
      get :following, :followers, :autocomplete
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :songs
    resources :posts, only: [:create, :destroy]
  resources :posts do
  resource :like, module: :posts
    member do
      post :repost
    end
  end
  resources :relationships, only: [:create, :destroy]

  # Define root url
  root 'home#home'
  # Define routes for Pages
  get '/home' => 'home#home'
  get '/posts/index' => 'posts#index'
  get '/users/:id' => 'home#profile'
  get 'users/:id/following' => 'users#show_following'
  get 'users/:id/followers' => 'users#show_followers'
  get 'users/:id/Music' => 'home#profileMusic'
  get 'posts/:post_id' => 'posts#show'
  get '/explore' => 'home#explore'
  get '/groupies' => 'home#groupies'
  get '/signup' => 'users#new'
  get '/login', to: 'sessions#new'
  get '/settings', to: 'users#edit'
  get'/password_reset', to: 'password_resets#new'
  get'/privacy_settings', to:'privacy_settings#edit'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get 'users/:id/add_song', to:'songs#new'
  #  get '/livestream' => 'audio#stream'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
