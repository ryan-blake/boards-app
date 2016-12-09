Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :boards
  resources :charges
  get 'complete_charge' => 'charges#complete'
  get 'relist_board' => 'boards#relist'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root to: 'boards#index'

end
