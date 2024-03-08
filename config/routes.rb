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



  namespace :admin do
    get 'homes/top'
    get 'users/index'
    get 'users/show'
    get 'users/edit'
    get 'post_images/show'
       get 'reviews/index'
    get 'tags/index'
  end

  scope module: :public do
    root to: 'home#top'
    get 'homes/about'
    get 'users/show'
    get 'users/edit'
    get 'users/unsubscribe'
      # member do
      # いいねした一覧 usersにネストして
      # get :liked_posts
    get 'post_images/new'
    get 'post_images/index'
    get 'post_images/show'
    get 'post_images/edit'
        get 'favorites/index'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end




