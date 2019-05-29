Rails.application.routes.draw do
  root 'homes#index'
  get 'crawl', to: 'homes#crawl', as: 'crawl'
  get 'category', to: 'homes#category', as: 'category'
  get 'user_detail/:id', to: 'homes#user_detail', as: 'user_detail'
  get 'back', to: 'homes#back', as: 'back'
  post 'execute_crawl', to: 'homes#execute_crawl', as: 'execute_crawl'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
