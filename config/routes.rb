Rails.application.routes.draw do
  resources :boards, only: [:new, :create, :edit, :update, :destroy]

  get '/profile', to: 'profile#show'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  root 'pins#index'

  resources :comments

  resources :pin_boards, except: [:show]

  resources :pins, path: 'pin'

  resources :users, only: [:new, :create, :edit, :update]

  resources :relationships

  get '/dashboard', to: 'users#show'
  get '/password_reset', to: 'passwords#new'
  post '/password_reset', to: 'passwords#create'
  put '/password_reset', to: 'passwords#update', as: "update_password"

  namespace :admin do
    get '/dashboard', to: 'dashboard#show'
    resources :pins
  end

  namespace :api do
    namespace :v1 do
      namespace :pins do
        get '/:id/comments', to: 'comments#index'
        post '/:id/comments', to: 'comments#create'
        put '/:id/comments', to: 'comments#update'
        delete '/:id/comments', to: 'comments#destroy'
      end
    end
  end

  get '/:user', to: 'users#show', as: 'show_user'

  namespace :users, as: :user, path: ":user" do
    get '/followers', to: 'followers#index', as: 'followers'
    get '/following', to: 'following#index', as: 'following'
    get '/:board', to: 'boards#show', as: 'board'
  end

  resources :relationships, only: [:create, :destroy]

  get '/dashboard', to: 'users#show'


end
