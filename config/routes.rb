Rails.application.routes.draw do

  # 会員側用
  # URL /users/sign_in...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # 会員側用ログアウト機能

   # 管理者側用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # 管理者側用ログアウト機能


  # namespace 「URI Pattern」と「Controller#Action」の2つを同時にカスタマイズしたい場合に使用
  namespace :admin do
    root to: 'homes#top'
    resources :users, only: [:index, :show, :edit, :update]
    resources :post_images, only: [:show] do
      resources :reviews, only: [:index, :destroy]
    end
    resources :tags, only: [:index, :destroy]
  end

  # （scope module）は「Controller#Action」のみカスタマイズしたい場合に使用
  scope module: :public do
    root to: 'homes#top'
    get 'homes/about', as:'about'
    resources :users, only: [:index, :show, :edit, :update]
      # member do
      # いいねした一覧 usersにネストして
      # get :liked_posts
    get 'users/unsubscribe', as:'unsubscribe'
    patch 'users/withdraw', as:'withdraw'
    resources :post_images, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resource :favorites, only: [:index, :create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end




