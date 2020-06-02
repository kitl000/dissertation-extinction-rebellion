Rails.application.routes.draw do

  get 'help', to: 'staticpages#help', as: 'help'
  resources :events
  post 'events/synch_all_events' => 'events#synch_all_events'
  put 'events/synch_event_by_id' => 'events#synch_event_by_id'
  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }
  resources :users

  resources :eventedits

  resources :contacts, only: [:new, :create]
  get 'contacts/new'

  get 'home/index'

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

