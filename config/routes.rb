Rails.application.routes.draw do
  root to: 'homes#top'
  get 'about', to: 'homes#about'
  get 'signup', to: 'users#new' # 新規登録画面を表示するURL
  post '/users', to: 'users#create' #登録を押したときにデータを処理するURL
  get    '/login',   to: 'sessions#new'     # ログイン画面を表示
  post   '/login',   to: 'sessions#create'  # ログイン処理
  delete '/logout',  to: 'sessions#destroy' # ログアウト処理
  post '/guest_login', to: 'sessions#guest_login' # ゲストログイン用のルートを追加
  
  resources :tasks do
    resource :cheers, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  
  resources :group_users, only: [:create, :update, :destroy]

  resources :groups, only: [:index, :create, :show, :edit, :update, :destroy]

  #自分の情報を扱うルート
  resources :users, only: [:show, :edit, :update, :destroy, :index]

  # 管理者専用のルーティング
  namespace :admin do
    resources :users, only: [:index, :destroy] # 一覧画面
    resources :tasks, only: [:index, :destroy]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
