Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :users, only: [:index]
  resources :courses do
    resources :course_attachments
  end
  resources :games
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
