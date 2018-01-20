Rails.application.routes.draw do
  resources :items
  root 'orders#index'

  get 'importxml' => 'import#importxml'
  get 'next_status/:id' => 'orders#next_status', as: :next_status
  get 'prev_status/:id' => 'orders#prev_status', as: :prev_status



  resources :orders
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
