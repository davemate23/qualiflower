Rails.application.routes.draw do
	
  devise_for :users
  resources :jobs
  resources :accreditations
  resources :locations
  get "/pages/*page" => "pages#show"
  get 'courses' => 'courses#index', as: :courses
  resources :courses, only: [:index, :new, :create, :destroy]
  resources :institutes do
  	resources :courses
  end
  root "pages#show", page: "home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
