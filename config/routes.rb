Rails.application.routes.draw do
  root 'events#index'

  resources :events
  resources :users, only: [:update, :edit, :show]

end
