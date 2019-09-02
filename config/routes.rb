Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, controllers: {
        registrations: 'users/registrations'
      }
  resources :users, only: [:index, :show] do
    resources :wishlists
  end
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
    resources :likes
    resources :wishgames
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
