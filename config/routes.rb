StoreEngine::Application.routes.draw do

  root :to => 'home#show'

  resources :users

  namespace :admin do
    resources :invoices do


      member do
        get :pay
        put :submit_payment
      end

      collection do
        post :generate_invoices, :as => :generate
        get  :store_invoices, :as => :store
        get ':year/:month' => 'invoices#index',
          :constraints => { :year => /\d{4}/, :month => /\d{2}/ },
          :as => 'monthly'
      end
    end

    get "dashboard" => "dashboard#show"
    resources :stores do
      put :activate
      put :decline
      put :disable
      put :enable
    end
  end

  resources :stores, :except => [:index, :show]

  resources :trips

  resources :orders do
    member do
      put :change_status, :as => "change_status_on"
    end
  end

  resources :line_items do
    member do
      put :increase
      put :decrease
    end
  end

  resources :carts

  get "profile"        => "users#show"
  match "edit/profile" => "users#edit"

  resource :session

  get "my_cart" => "carts#show"

  get "logout" => "sessions#destroy",   :as => "logout"
  get "login"  => "sessions#new",       :as => "login"
  get "signup" => "users#new",          :as => "signup"
  get "search" => "search#user_search", :as => "search"

  scope "/:store_slug" do

    resources :categories
    get "/" => "products#index", as: "home"
    resources :products, :only => :show

    namespace :admin do
      get "/" => "stores#show", :as => "home"

      scope "/:users" do
        delete "remove_stocker" => "stores#remove_stocker"
        delete "remove_admin" => "stores#remove_admin"
      end

      resources :products do
        member do
          put :retire
          put :unretire
        end
      end

      resources :orders
      post "create_admin" => "stores#create_admin"
      get "new_admin" => "stores#new_admin"
      post "create_stocker" => "stores#create_stocker"
      get "new_stocker" => "stores#new_stocker"
    end
  end
end
