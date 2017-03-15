Rails.application.routes.draw do


  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :users do
     resources :reviews
  end

  resources :boards do
    collection do
      get 'search', 'search_signed_in', 'sort_order'
    end
  end

  resources :charges
  resources :tokens, only: [:new, :create]
  get 'charges/complete'

  get 'messages/create'
  get 'conversations/create'
  resources :conversations, only: [:create] do
    member do
      post :close
    end
    resources :messages, only: [:create]
  end


  get 'relist_board' => 'boards#relist'
  get 'my_boards' => 'pages#boards'
  get 'profile' => 'pages#profile'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'boards#index'

get "/fetch_items" => 'boards#from_type', as: 'fetch_items'

end
