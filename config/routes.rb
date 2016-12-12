Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :boards do
    collection do
  get 'search'
end
end
  resources :charges
  get 'complete_charge' => 'charges#complete'
  get 'relist_board' => 'boards#relist'
  get 'my_boards' => 'pages#boards'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'boards#index'

end
