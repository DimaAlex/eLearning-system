Rails.application.routes.draw do
  resources :organizations do
    get 'all_users', to: 'organization_users#users_in_org'
    get 'add_users_to_org', to: 'organization_users#add_users_to_org'
    get 'add_org_admins_to_org', to: 'organization_users#add_org_admins_to_org'
    post 'create_users', to: 'organization_users#create_users_in_org'
    post 'create_org_admins', to: 'organization_users#create_org_admins_in_org'
    post 'import', to: 'organization_users#import_users_from_file', as: 'import_users'
  end

  resources :courses do
    resources :pages
  end
  root to: 'home#index'

  resources :courses, only: :index do
    collection do
      post :import
      get :autocomplete
    end
  end
  match '/courses/:id/start_course' => 'courses#start_course', via: [:get, :post], :as => :start_course
  match '/courses/:course_id/pages/:id/finish_page' => 'pages#finish_page', via: [:get, :post], :as => :finish_page

  get 'admin', to: 'admin#index'
  get '/user/:id', to: 'users#profile', as: 'user_profile'
  resources :input_user_answers, only: [:create, :update]
  get '/user/show', to: 'users#show'

  devise_for :users, controllers: {
    sessions: 'devise/sessions',
    registrations: "users/registrations"
  }

  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "mailbox/sent" => "mailbox#sent", as: :mailbox_sent
  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash

  get "conversations/get_recipients" => "conversations#get_recipients"

  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
      post :empty_trash
    end
  end

  get "org_admins/:id/impersonate" => "org_admins#impersonate", as: :impersonate
  get "org_admins/not_impersonate" => "org_admins#stop_impersonate", as: :stop_impersonate

  get "admins_impersonations/:id/index" => "admins_impersonations#index", as: :admins_impersonations

end
