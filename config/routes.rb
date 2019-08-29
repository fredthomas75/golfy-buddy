Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :users, only: [:index, :show] do
    resources :user_personalities
    resources :user_preferences
  end
  # Routes for HasFriendship
    post '/user/:id/friendships',    to: 'friendships#request_frd', as: :friendships_request
    post '/user/:id',   to: 'friendships#confirm_frd', as: :friendships_confirm
    post '/user/:id',   to: 'friendships#decline_frd', as: :friendships_decline
    delete '/user/:id',  to: 'friendships#remove_frd', as: :friendships_remove
  resources :list_preferences
  resources :courses do
    resources :attachments
  end
  resources :games do
    resources :attachments
    resources :guests, only: [:index, :create, :update, :destroy]
  end
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
