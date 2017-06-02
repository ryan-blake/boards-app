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

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :users do
     resources :reviews
  collection do
      get 'search', 'users/search_signed_in/:id', 'sort_order', to: "users#search_signed_in"
  end
end
get'maps' => 'users#maps'



  resources :boards do
    resources :events, only: [:create, :destroy, :show, :board_dash]
    collection do
      get 'search_dash', 'search_signed_in', 'sort_order', 'board_dash', 'rental_boards', 'active_boards', 'inactive_boards',
         'shipped_boards', 'pending_boards', 'pick_boards', 'sales_boards', 'company_search'
    end
    collection do
      post  'import'
    end
  end
  get'dash' => 'boards#board_dash'

  resources :charges
  resources :tokens, only: [:new, :create]

  get 'complete_charge' => 'charges#complete'
  get 'complete_charge' => 'charges#retrieve'

  resources :conversations, only: [:create] do
    member do
      post :close
    end
    resources :messages, only: [:create]
  end

    get'msg' => 'conversations#msg'
    get 'conversations/create'
    get 'messages/create'

  get 'relist_board' => 'boards#relist'
  get 'my_boards' => 'pages#boards'
  get 'profile' => 'pages#profile'

  resources :events

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'boards#index'

get "/fetch_items" => 'boards#from_type', as: 'fetch_items'

end
