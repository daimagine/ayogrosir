NuAyogrosir::Application.routes.draw do
  
  get "dashboard/index"

  devise_for :users
  resources :users
  
  # markets routes
  resources :markets, :only => [:index, :show] do
  	member do
  		get 'default'
  	end
  end
  
  # stores routes
  resources :stores, :only => [:index, :show] do 
    member do
      post 'follow' => 'followers#create'
      delete 'unfollow' => 'followers#destroy'
    end
  end

  # products routes
  resources :products, :only => [:index, :show]

  # manage admin (backend)
  match :admin, :to => 'admin/dashboard#index'
  namespace :admin do
    resources :markets, :stores, :products
  end

  # manage static pages
  get '/:slug' => 'pages#index', as: 'page'

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
end