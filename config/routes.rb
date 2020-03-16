Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :products
  get 'about_us/contact'
  post 'about_us/thank_you'

  get 'home/index'

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
