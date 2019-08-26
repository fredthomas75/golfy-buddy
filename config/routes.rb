Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :users, only: [:index, :show]
  resources :courses do
    resources :attachments
  end
  resources :games do
    resources :attachments
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
