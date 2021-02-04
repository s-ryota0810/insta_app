Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :timeline, only: [:show]
  resources :accounts, only: [:show, :edit, :update] do
    resource :follows, only: [:create, :destroy, :show]
    resources :followings, only: [:index]
    resources :followers, only: [:index]
  end
  root to: 'timelines#show'
  resource :profile
  resources :articles do
    resources :images
    resource :likes 
    resources :comments
  end
end
