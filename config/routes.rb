Rails.application.routes.draw do
	
  resources :reviews, except: [:show, :index]
  devise_for :users
  resources :jobs
  resources :accreditations
  resources :locations
  get "/pages/*page" => "pages#show"
  get 'courses' => 'courses#index', as: :courses
  resources :courses
  resources :institutes do
  	resources :courses
  end
  root "pages#show", page: "home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
