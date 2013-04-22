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
    resources :markets do
      member do 
        get 'new_store', :action => 'new_store', :as => 'new_store'
        post 'new_store/:store_id', :action => 'create_store', :as => 'new_store'
        delete 'remove_store/:store_id', :action => 'remove_store', :as => 'remove_store'
      end
    end
    resources :categories, :stores, :products
  end

  # manage static pages
  get '/:slug' => 'pages#index', as: 'page'

  post 'subscribe' => 'subscriptions#create'

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
end