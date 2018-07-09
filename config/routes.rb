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
  get 'record/find'
  get 'record/find_by'
  get 'record/where'
  get 'record/keyword'
  post 'record/ph1'
  get 'record/not(/:id)', to: 'record#not'
  get 'record/where_or'
  get 'record/order'
  get 'record/reorder'
  get 'record/select'
  get 'record/select2'
  get 'record/offset'
  get 'record/page(/:id)', to: 'record#page'
  get 'record/last'
end
