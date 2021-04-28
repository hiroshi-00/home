Rails.application.routes.draw do
  devise_for :admins, :controllers => {
    :sessions => 'admins/sessions'
  }

  devise_scope :admin do
    get "dashboard", :to => "dashboard#index"
    get "dashboard/login", :to => "admins/sessions#new"
    post "dashboard/login", :to => "admins/sessions#create"
    get "dashboard/logout", :to => "admins/sessions#destroy"
  end
  
  namespace :dashboard do 
    resources :categories, except: [:new] do
      collection do
        get 'main_categories', to: 'categories#main_categories', as: 'main_categories'
        get 'grandchildren_categories', to: 'categories#grandchildren_categories', as: 'grandchildren_categories'
      end
    end
    resources :items
    resources :posts
    get 'get_category/children', to: 'items#get_category_children', defaults: { format: 'json' }
    get 'get_category/grandchildren', to: 'items#get_category_grandchildren', defaults: { format: 'json' }
  end
  

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords',
    :confirmations => 'users/confirmations',
    :unlocks => 'users/unlocks',
  }

  devise_scope :user do
    root :to => "users/sessions#new"
    get "signup", :to => "users/registrations#new"
    get "verify", :to => "users/registrations#verify"
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
  end
  
  resource :users, only: %i[edit update] do
    collection do
      get "mypage", :to => "users#mypage"
      get "mypage/edit", :to => "users#edit"
      put "mypage", :to => "users#update"
      get  "mypage/favorite", :to => "users#favorite"
    end
  end
  resources :items do
    resources :reviews, only: :create
    resource :skills, only: :create
    resource :likes, only: %i[create destroy]
  end
  
  resources :gachas, only: :index
  resources :posts, only: %i[index show]
  
  get 'get_category/new', to: 'items#category_window', defaults: { format: 'json' }
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
