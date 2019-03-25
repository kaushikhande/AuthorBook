Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, :controllers => {
    sessions: 'users/sessions',
    registrations: 'registrations'
  }  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "authors#index"
  resources :authors
  resources :books
end
