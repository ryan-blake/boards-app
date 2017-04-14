Rails.application.routes.draw do

  resources :events

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :users do
     resources :reviews
  collection do
      get 'search', 'users/search_signed_in/:id', 'sort_order', to: "users#search_signed_in"
  end
end

  resources :boards do
    resources :events, only: [:create, :destroy, :show, :board_dash]
    collection do
      get 'search', 'search_signed_in', 'sort_order', 'board_dash'
    end
  end
  get'dash' => 'boards#board_dash'
  get'active' => 'boards#active'



  resources :charges, only: [:new, :create, :complete]
  resources :tokens, only: [:new, :create]

  get 'complete_charge' => 'charges#complete'
  get 'complete_charge' => 'charges#retrieve'

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
