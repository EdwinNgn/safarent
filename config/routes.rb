Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :animals do
    resources :bookings, only: [:index, :new, :create]
  end
  resources :bookings, only: [:destroy, :show] do
    resources :reviews, only: [:new, :create]
  end
  resources :profils, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  patch 'bookings/:id/accept', to: "bookings#accept", as: "booking_accept"
  patch 'bookings/:id/refuse', to: "bookings#refuse", as: "booking_refuse"
end
