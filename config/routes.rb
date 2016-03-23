Rails.application.routes.draw do
  resources :organizations

  resources :courses do
    resources :pages
  end
  root to: 'home#index'

  get 'admin', to: 'admin#index'

  devise_for :users, controllers: {
      sessions: 'devise/sessions'
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
