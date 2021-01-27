Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'articles#index'
  resource :profile
  resources :articles do
    resources :images
    resource :likes 
  end
end
