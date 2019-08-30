Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :users, only: [:index, :show] do
    resources :user_personalities
    resources :user_preferences
  end
  get '/users/:id/new_preferences', to: 'users#new_preferences', as: :new_preferences
  patch '/users/:id', to: 'users#set_preferences'
  get '/users/:id/new_personalities', to: 'users#new_personalities', as: :new_personalities
  patch '/users/:id', to: 'users#set_personalities'
  # Routes for HasFriendship
    post '/users/:id/friendships',    to: 'friendships#request_frd', as: :friendships_request
    post '/users/:id',   to: 'friendships#confirm_frd', as: :friendships_confirm
    post '/users/:id',   to: 'friendships#decline_frd', as: :friendships_decline
    delete '/users/:id',  to: 'friendships#remove_frd', as: :friendships_remove
  resources :list_preferences
  resources :courses do
    resources :attachments
  end
  resources :games do
    resources :attachments
    resources :guests, only: [:index, :create, :update, :destroy]
  end
  get '/games/approve_user/:id', to: 'guests#approve_user', as: :approve_user
  get '/games_buddies', to: 'games#games_buddies', as: :games_buddies
  resources :messages, only: [:new, :create]
  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      post :restore
      post :mark_as_read
    end
      collection do
      delete :empty_trash
    end
  end
end
