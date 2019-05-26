Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    root to: 'employees#desboart'

    resources :trackings, only: :index do
      collection do
        get :analysis
        get :delete_tracking
        get :hot_analysis
      end
    end

    resources :employees do
      collection do
        get  :forget_password
        post :forget_password
        get  :reset_mail
        get  :error_mail
        get  :add_roles
        post :save_roles
        get  :desboart
      end
    end

    resources :users do
      collection do
        root to: 'users#index'
        get  :desboart
      end
    end

    resources :vendors do
      collection do
        post :upload_image
      end
    end

    resources :markets do
      collection do
        post :upload_image
      end
    end

    resources :markets do
      collection do
        post :upload_image
      end
    end

  end

  resources :attachments do
  end

  namespace :web do
    resources :center do
      collection do
        get :my_vendor
        get :my_visit
        get :my_search
        get :visits_converse_create 
      end
    end
  end

  resources :customers do
    collection do
      post :upload_image
      get :logout
      get :detail
    end
  end
  
  resources :vendors do
    collection do
      post :upload_image
      get :show_gps
      get :add_comments
      get :top_search
    end
  end

  resources :trackings 


  root to: 'vendors#index'
  devise_for :employees, path: "admin", path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', sign_up: 'cmon_let_me_in' }, controllers: { sessions: "admin/sessions", passwords: "admin/passwords"}
  devise_for :users, path: "web", path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', sign_up: 'cmon_let_me_in' }, controllers: { sessions: "web/sessions", passwords: "web/passwords"}

end
