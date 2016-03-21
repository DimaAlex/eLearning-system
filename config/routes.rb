Rails.application.routes.draw do
  resources :courses
  root to: 'home#index'


  devise_for :users, controllers: {
      sessions: 'devise/sessions'
  }
end
