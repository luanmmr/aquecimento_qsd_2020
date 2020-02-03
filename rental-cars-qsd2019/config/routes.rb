Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index', only: [:index]
  # É possível escolher quais routes serão criadas
  #resources :manufacturers, only: [:index, :show, :new]
  resources :manufacturers, only: [:new, :create, :edit, :update, :destroy]
  resources :subsidiaries#,   only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :car_categories, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :car_models, only: [:new, :create, :edit, :update, :destroy]
  resources :clients, only: [:new, :index, :create, :edit, :update, :destroy]
  resources :cars

  resources :rentals, only: [:index, :show, :new, :create, :destroy] do
    get 'search', on: :collection
    get 'reserve', on: :member
    post 'reserve', on: :member, to: 'rentals#create_reserve'
  end

  namespace :api do
    namespace :v1 do
      resources :cars, only: [:index, :show, :create, :update]
      resources :rentals, only: :create
    end
  end



end
