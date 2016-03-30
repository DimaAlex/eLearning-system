Rails.application.routes.draw do
  resources :organizations

  resources :courses do
    resources :pages
  end
  root to: 'home#index'

  resources :courses, only: :index do
    collection do
      post :import
      get :autocomplete # <= add this line
    end
  end

  get 'admin', to: 'admin#index'
  get '/user/:id=', to: 'users#profile', as: 'user_profile'
  get '/user/show', to: 'users#show'

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
