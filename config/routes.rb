Rails.application.routes.draw do
  resources :fan_comments
  resources :reviews
  resources :authors
  resources :users
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'hello/index', to: 'hello#index'
  get 'hello/view'
  get 'hello/list'
  get 'ajax/upanel', to: 'ajax#upanel'
  # post 'ajax/upanel', to: 'ajax#upanel'
  get 'ajax/search', to: 'ajax#search'
  post 'ajax/result', to: 'ajax#result'
end
