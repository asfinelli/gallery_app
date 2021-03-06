Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'posts#index'
  devise_for :users
  resources :users do
    resources :posts
  end
  resources :posts do
    resources :comments
  end


 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
