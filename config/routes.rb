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

  # manage static pages
  get '/:slug' => 'pages#index', as: 'page'

  # manage admin (backend)
  match :admin, :to => 'admin/dashboards#index'
  namespace :admin do
    resources :users, :markets, :stores, :products
  end

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
end