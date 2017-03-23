require 'sidekiq/web'
Rails.application.routes.draw do
	
  devise_for :admins
  resources :job_profiles
  resources :job_categories
  #devise_for :users
  resources :jobs
  resources :accreditations
  resources :locations
  get "/pages/*page" => "pages#show"
  get 'courses' => 'courses#index', as: :courses
  resources :courses do
    resources :comments
  end
  devise_for :users, controllers: { sessions: 'sessions',registrations: 'registrations' }
  # devise_for :admins
  resources :institutes do
    resources :comments
  	resources :courses 
  end
  root "pages#show", page: "home"

  mount Sidekiq::Web => '/sidekiq'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
