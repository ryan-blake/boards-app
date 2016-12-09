Rails.application.routes.draw do
  get 'omniauth_callbacks/stripe_connect'

  devise_for :users
  resources :boards
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root to: 'boards#index'

end
