NuAyogrosir::Application.routes.draw do
  
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

  resources :products, :only => [:index, :show]

  get '/:slug' => 'pages#index', as: 'page'

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
end