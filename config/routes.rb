Rails.application.routes.draw do
  # resources :fan_comments
  # resources :reviews
  # resources :authors
  # resources :users
  # resources :books, constraints: { id: /[0-9]{1,2}/ }, constraints: TimeConstraint.new, format: false
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get 'hello/index', to: 'hello#index'
  # get 'hello/view'
  # get 'hello/list'
  #
  # namespace :admin do
  #     resources :books
  # end

  # resources :reviews do
  #     collection do
  #         get :unapproval
  #     end
  #     member do
  #         get :draft
  #     end
  # end

  # resources :books do
  #     resources :reviews
  # end

  # resources :books do
  #     resources :reviews, shallow: true
  # end

  # scope shallow_path: :b do
  #     resources :books do
  #         resources :reviews, shallow: true
  #     end
  # end

  # concern :additional do
  #     get :unapproval, on: :collection
  #     get :draft, on: :member
  # end
  #
  # resources :reviews, concerns: :additional

  # match '/details(/:id)' => 'hello#index', via: [ :get, :post]

  get 'hello/view'
  get '/articles(/:category)' => 'articles#index', defaults: { category: 'general', format: 'xml' }
  get 'blogs/:user_id' => 'blogs#index', constraints: { user_id: /[A-Za-z0-9]{3,7}/}

  root to: 'books#index'
end
