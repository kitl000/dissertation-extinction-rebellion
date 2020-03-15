Rails.application.routes.draw do
  resources :products
  get 'about_us/contact'
  get 'home/index'

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
