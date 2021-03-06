require 'sidekiq/web'

Rails.application.routes.draw do
  match "/404", :to => "errors#not_found", :via => :all, as: 'errors_not_found'

  resources :organizations, only: :index do
    collection do
      get :autocomplete
    end
  end

  resources :organizations do
    get 'all_users', to: 'organization_users#users_in_org'
    get 'add_users_to_org', to: 'organization_users#add_users_to_org'
    get 'add_org_admins_to_org', to: 'organization_users#add_org_admins_to_org'

    post 'create_users', to: 'organization_users#create_users_in_org'
    post 'create_org_admins', to: 'organization_users#create_org_admins_in_org'
    post 'import', to: 'organization_users#import_users_from_file', as: 'import_users'

    put 'accept', to: 'invitation#accept_on_invite', as: 'invitation_accept'
    put 'reject', to: 'invitation#reject_on_invite', as: 'invitation_reject'

    post 'follow', to: 'invitation#follow_on_organization'
    post 'leave', to: 'invitation#leave_organization'

    put '/user/:user_id/accept_request', to: 'invitation#accept_request_on_entrance', as: 'accept_request'
    put '/user/:user_id/reject_request', to: 'invitation#reject_request_on_entrance', as: 'reject_request'

    delete '/user/:user_id/delete', to: 'organization_users#delete_user', as: 'delete_user'
  end

  mount Sidekiq::Web, at: '/sidekiq'

  resources :courses, only: :index do
    collection do
      get :autocomplete
    end
  end

  get 'organizations/:id/courses', to: 'organizations#courses_in_org', as: 'organization_courses'

  resources :courses do
    resources :pages
    get 'add_users_individual_course', to: 'users_courses#add_users_individual_course'
    post 'create_users_individual_course', to: 'users_courses#create_users_individual_course'
    post 'like_course', to: 'users_courses#like_course'
  end
  root to: 'home#index'

  match '/organizations/:id/report' => 'organizations#report', via: [:get, :post], :as => :report
  match '/courses/:id/start_course' => 'users_courses#start_course', via: [:get, :post], :as => :start_course
  match '/courses/:course_id/pages/:id/finish_page' => 'pages#finish_page', via: [:get, :post], :as => :finish_page

  get 'admin', to: 'admin#index'
  get '/user/:id', to: 'users#profile', as: 'user_profile'
  get 'certificates', to: 'users#certificates', as: 'user_certificates'
  get 'users/:id/courses/', to: 'users#courses', as: 'users_courses'
  get 'users/:id/organizations', to: 'users#organizations', as: 'user_organizations'

  resources :input_user_answers, only: [:create, :update]
  get 'certificates/show', to: 'users#show'

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

  resources :estimation
  resources :certificate
  post "create_users_courses/:id" => "courses#create_users_courses", as: :create_users_courses
  post "course_result/:id" => "courses#course_result", as: :course_result

  get "org_admins/:id/impersonate" => "org_admins#impersonate", as: :impersonate
  get "org_admins/not_impersonate" => "org_admins#stop_impersonate", as: :stop_impersonate

  get "admins_impersonations/:id/index" => "admins_impersonations#index", as: :admins_impersonations

end
