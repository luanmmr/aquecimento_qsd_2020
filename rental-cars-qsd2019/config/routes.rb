Rails.application.routes.draw do
  root to: 'home#index'
  resources :manufacturers, only: [:index, :show]
end
