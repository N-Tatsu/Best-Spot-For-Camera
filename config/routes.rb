Rails.application.routes.draw do

  # 会員側用
  # URL /users/sign_in...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # 会員側用ログアウト機能

  #ゲストログインのコントローラへ繋ぐルーティング
  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

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
    resources :post_images, only: [:show]
    resources :reviews, only: [:index, :destroy]
    resources :tags, only: [:index, :destroy]
  end

  # （scope module）は「Controller#Action」のみカスタマイズしたい場合に使用
  scope module: :public do
    root to: 'homes#top'
    get 'users/unsubscribe', as: 'user_unsubscribe'
    patch 'users/withdraw', as: 'withdraw_user'
    resources :users, only: [:index, :show, :edit, :update] do
      member do #1つのデータに対して行う処理を定義することができる
        get :favorites     # いいねした一覧 usersにネストして
      end
    end

    resources :post_images, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resource :favorite, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    get '/search', to: 'searches#search'
    get 'search_tag' => 'post_images#search_tag'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end




