Rails.application.routes.draw do
  get 'bookings/new'
  get 'reviews/new'
  get 'animals/index'
  get 'animals/show'
  get 'animals/create'
  get 'animals/new'
  get 'animals/edit'
  get 'animals/update'
  get 'animals/destroy'
  devise_for :users
  root to: 'pages#home'
  resources :animals do
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:destroy, :show] do
    resources :reviews, only: [:new, :create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
