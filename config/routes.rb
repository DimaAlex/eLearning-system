Rails.application.routes.draw do
  resources :courses do
    resources :pages
  end
  root to: 'home#index'


  devise_for :users, controllers: {
      sessions: 'devise/sessions'
  }
end
