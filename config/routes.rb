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
  get 'ctrl/para(/:id)', to: 'ctrl#para'
  get 'ctrl/para_array(/:id)', to: 'ctrl#para_array'
  get 'ctrl/req_head'
  get 'ctrl/req_head2'
  get 'ctrl/upload'
  post 'ctrl/upload', to: 'ctrl#upload_process'
  get 'ctrl/updb(/:id)', to: 'ctrl#updb'
  patch 'ctrl/updb_process(/:id)', to: 'ctrl#updb_process'
  get 'ctrl/html_plain'
  get 'ctrl/log'
  get 'ctrl/get_xml'
  get 'ctrl/get_json'
  get 'ctrl/download'
  get 'ctrl/cookie'
  post 'ctrl/cookie_rec'
  get 'ctrl/session_show', to: 'ctrl#session_show'
  post 'ctrl/session_rec'
  get 'ctrl/index'
  resources :hello
  get 'ctrl/device'
end
