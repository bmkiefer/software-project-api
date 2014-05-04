DeviseExample::Application.routes.draw do

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post 'registrations' => 'registrations#create', :as => 'register'
        post 'sessions' => 'sessions#create', :as => 'login'
        delete 'sessions' => 'sessions#destroy', :as => 'logout'
      end
      post 'pictures' => 'pictures#create'
      get 'polls'  => 'polls#index'
      post 'polls' => 'polls#create'
      post 'texts' => 'texts#create'
      post 'skips' => 'skips#create'
      post 'votes' => 'votes#create'
      get 'user_polls' => 'user_polls#index'
      post 'back_user_polls' => 'back_user_polls#create'
      post 'next_user_polls' => 'next_user_polls#create'
      get 'own_polls' => 'own_polls#show'	
      post 'own_polls' => 'own_polls#index'
      delete 'own_polls' => 'own_polls#delete'
    end
  end

  devise_for :users, :admins

  get '/token' => 'home#token', as: :token

  resources :home, only: :index
  resources :admins, only: :index

  root 'home#index'

end
