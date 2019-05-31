Rails.application.routes.draw do
  root 'homes#index'
  get 'crawl', to: 'homes#crawl', as: 'crawl'
  get 'category', to: 'homes#category', as: 'category'
  get 'user_detail/:id', to: 'homes#user_detail', as: 'user_detail'
  get 'back', to: 'homes#back', as: 'back'
  post 'execute_crawl', to: 'homes#execute_crawl', as: 'execute_crawl'
  get 'category_detail/:id', to: 'homes#category_detail', as: 'category_detail'
  get 'export_xlsx', to: 'export_data#execute', as: 'export_xlsx'
  get 'export_data', to: 'export_data#index', as: 'export_data'
  get 'statistic', to: 'statistic_star#index', as: 'statistic'
  post 'statistic_search', to: 'statistic_star#search', as: 'statistic_search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
