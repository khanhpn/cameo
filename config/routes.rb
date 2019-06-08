Rails.application.routes.draw do
  root 'homes#index'
  get 'crawl', to: 'homes#crawl', as: 'crawl'
  get 'category', to: 'homes#category', as: 'category'
  get 'user_detail/:id', to: 'homes#user_detail', as: 'user_detail'
  get 'back', to: 'homes#back', as: 'back'
  get "search_user", to: 'homes#search_user', as: 'search_user'
  post 'execute_crawl', to: 'homes#execute_crawl', as: 'execute_crawl'
  get 'category_detail/:id', to: 'homes#category_detail', as: 'category_detail'
  get 'export_xlsx', to: 'export_data#execute', as: 'export_xlsx'
  get 'export_data', to: 'export_data#index', as: 'export_data'
  get 'statistic', to: 'statistic_star#index', as: 'statistic'
  post 'statistic_search', to: 'statistic_star#search', as: 'statistic_search'
  get 'celebvm', to: 'homes#celebvm', as: 'celebvm'
  get 'category_celebvm', to: 'homes#category_celebvm', as: 'category_celebvm'
  get 'category_celebvm_detail/:id', to: 'homes#category_celebvm_detail', as: 'category_celebvm_detail'
  get 'user_celebvm_detail/:id', to: 'homes#user_celebvm_detail', as: 'user_celebvm_detail'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
