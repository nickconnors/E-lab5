Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  get 'admin', to: 'admin#home'

  get 'studenthome', to: 'studenthome#index'
  get 'teacherhome', to: 'teacherhome#index'

  get 'course_refresh', to: 'courses#refresh'
  get 'course_refresh', to: 'courses#'
  get 'scrape', to: 'scraper#scrape'
  get 'open_courses', to: 'students#open_courses'

  resources :scraper
  resources :courses
  resources :students
  resources :admin
  resources :users
  resources :recommendations
  resources :requests
  resources :evaluations
end
