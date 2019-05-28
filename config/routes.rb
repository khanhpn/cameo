Rails.application.routes.draw do
  root 'homes#index'
  get 'crawl', to: 'homes#crawl', as: 'crawl'
  get 'category', to: 'homes#category', as: 'category'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
