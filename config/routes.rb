NuAyogrosir::Application.routes.draw do
  
  devise_for :users
  resources :users
  # markets routes
  resources :markets, :only => [:index, :show] do
  	member do
  		get 'default'
  	end
  end
  resources :stores, :only => [:index, :show]
  resources :products, :only => [:index, :show]

  get '/:slug' => 'pages#index', as: 'page'

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
end