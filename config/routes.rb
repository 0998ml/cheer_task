Rails.application.routes.draw do
  get "tasks/index"
  get "tasks/show"
  get "tasks/new"
  get "tasks/edit"
  get "homes/about"
  root to: 'homes#top'
  get 'about', to: 'homes#about'
  get 'signup', to: 'users#new' # 新規登録画面を表示するURL
  post '/users', to: 'users#create' #登録を押したときにデータを処理するURL
  get    '/login',   to: 'sessions#new'     # ログイン画面を表示
  post   '/login',   to: 'sessions#create'  # ログイン処理
  delete '/logout',  to: 'sessions#destroy' # ログアウト処理
  resources :tasks   #タスクのCRUD用のルートを一括作成（一覧、詳細、新規、編集、削除すべてを1行で作成）
  #自分の情報を扱うルート
  resource :users, only: [:show, :edit, :update, :destroy]
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
