Rails.application.routes.draw do
  resources :organizations
  get 'organizations/:id/all_users', to: 'organizations#users_in_org', as: :organization_all_users
  get 'organizations/:id/new_users', to: 'organizations#new_users_to_org', as: :organization_new_users
  post 'organizations/:id/create_users', to: 'organizations#create_users_to_org', as: :organization_create_users
  post 'organizations/:id/import', to: 'organizations#import', as: :import_emails

  resources :courses do
    resources :pages
  end
  root to: 'home#index'

  get 'admin', to: 'admin#index'
  get '/user/:id=', to: 'users#profile', as: 'user_profile'

  devise_for :users, controllers: {
      sessions: 'devise/sessions',
      registrations: "users/registrations"
  }

  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "mailbox/sent" => "mailbox#sent", as: :mailbox_sent
  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash

  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
      post :empty_trash
    end
  end

end
