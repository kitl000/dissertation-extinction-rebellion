Rails.application.routes.draw do
  resources :events
  post 'events/synch_all_events' => 'events#synch_all_events'
  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }
  resources :users
  # resources :products
  get 'about_us/contact'
  post 'about_us/thank_you'
  get 'home/index'

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
