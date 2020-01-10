Rails.application.routes.draw do
  root to: 'home#index', only: [:index]
  # É possível escolher quais routes serão criadas
  #resources :manufacturers, only: [:index, :show, :new]
  resources :manufacturers,  only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :subsidiaries,   only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :car_categories, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :car_models,     only: [:index, :new, :create, :show, :edit, :update, :destroy]
end
