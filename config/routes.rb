Rails.application.routes.draw do
  get 'messages/create'

  get 'conversations/create'

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :boards do
    collection do
      get 'search', 'search_signed_in', 'sort_order'
    end
  end

  resources :charges
  get 'complete_charge' => 'charges#complete'
  get 'complete_charge' => 'charges#retrieve'

  resources :conversations, only: [:create] do
    member do
      post :close
    end
    resources :messages, only: [:create]
  end
  get 'relist_board' => 'boards#relist'
  get 'my_boards' => 'pages#boards'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'boards#index'

get "/fetch_items" => 'boards#from_type', as: 'fetch_items'

end
