Rails.application.routes.draw do

# crons
require 'sidekiq/web'
require 'sidekiq/cron/web'
mount Sidekiq::Web => '/sidekiq'

  # mngd
  get 'terms', to: 'pages#terms'
  resources :stripe_accounts
  resources :bank_accounts

  # !mngd
  resources :accessories do
    collection do
      get 'table', 'search_table', 'search_accessories'
    end
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :users do
     resources :reviews
  collection do
      get  'search', 'users/search_signed_in/:id', 'sort_order',  to: "users#search_signed_in"
  end
end
get'maps' => 'users#maps'
get 'accessoryInventory', to: 'accessories#inventory'

resources :events do
  collection do
      get 'rental_boards','search_rental'
    end
end
  resources :boards do
    resources :accessories
    resources :sizes
    resources :events, only: [:create, :destroy, :show, :board_dash]
    collection do
      get  'search_dash', 'search_type', 'search_signed_in', 'sort_order', 'board_dash',  'active_boards', 'inactive_boards',
         'shipped_boards', 'pending_boards', 'pick_boards', 'sales_boards', 'company_search'
    end
    collection do
      post  'import'
    end

  end

  get'dash' => 'boards#board_dash'
get 'featured' => 'boards#show'

  resources :charges
  resources :tokens, only: [:new, :create]

  get 'complete_charge' => 'charges#complete'
  get 'complete_charge' => 'charges#retrieve'

  get'msg' => 'conversations#msg'
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

  resources :events

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'boards#index'

get "/fetch_items" => 'boards#from_type', as: 'fetch_items'

end
