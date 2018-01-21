Rails.application.routes.draw do
  root 'orders#index'
  resources :users
  resource :session, only: [:new, :create, :destroy]

  resources :orders do
  resources :shippings
  resources :items
  end

  get 'importxml' => 'import#importxml'
  get 'next_status/:id' => 'orders#next_status', as: :next_status
  get 'prev_status/:id' => 'orders#prev_status', as: :prev_status
  get 'aanmelden' => 'users#new'
  get "inloggen" => "sessions#new"



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
