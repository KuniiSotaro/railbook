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
  get 'record/last'
  get 'record/groupby'
  get 'record/havingby'
  get 'record/where2'
  get 'record/unscope'
  get 'record/none(/:id)', to: 'record#none'
  get 'record/pluck'
  get 'record/exists'
  get 'record/scope'
  get 'record/def_scope'
  get 'record/count'
  get 'record/average'
  get 'record/groupby'
  get 'record/update_all'
  get 'record/update_all2'
  delete 'record/destroy_all'
end
