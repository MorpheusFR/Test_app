Rails.application.routes.draw do
  root                   'static_pages#home'

  get     'help'      => 'static_pages#help'
  get     'about'     => 'static_pages#about'
  get     'contact'   => 'static_pages#contact'

  get     'signup'    => 'users#new'

  get     'login'     => 'sessions#new'
  post    'login'     => 'sessions#create'
  delete  'logout'    => 'sessions#destroy'

  get     'todolists' => 'todo_lists#index'
  
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :todo_lists do
    resources :todo_items do
      member do
        patch :complete
        post 'priority_up'
        post 'priority_down'
      end
    end
  end

  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]

end
