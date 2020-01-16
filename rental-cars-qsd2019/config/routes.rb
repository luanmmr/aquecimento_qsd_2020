Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index', only: [:index]
  # É possível escolher quais routes serão criadas
  #resources :manufacturers, only: [:index, :show, :new]
  resources :manufacturers#,  only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :subsidiaries#,   only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :car_categories#, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :car_models#,     only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :clients
  resources :rentals, only: [:index, :show, :new, :create] do
    get 'search', on: :collection
    get 'reserve', on: :member
    post 'create_reserve', on: :member
    get 'show_reserve', on: :member
  end

end
