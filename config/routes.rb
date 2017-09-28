Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  get 'users/new'

  get 'help' , to: 'static_pages#help'
  get'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'
  get 'signup', to:'users#new'
  get 'home', to: 'static_pages#home'
  root'static_pages#home'
get '/update', to: 'users#edit'

  post '/signup', to: 'users#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
get '/index', to: 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



    resources :users do
    member do
      get :following, :followers
    end
  end

    resources :account_activations, only: [:edit]
    resources :password_resets, only: [:new, :create, :edit ,:update], param: :token
  #  resources :microposts , only: [:create , :destroy]
    resources :relationships , only: [:create , :destroy]



    resources :microposts do
      resources :likes , only: [:create , :destroy]
    end
end
