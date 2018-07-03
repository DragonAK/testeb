Rails.application.routes.draw do

  devise_for :users

  resources :materials do
    member do
      get :log
    end
  end

  as :user do
  	get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'


end
