Rails.application.routes.draw do
	
  resources :jobs
  resources :accreditations
  resources :locations do
  	resources :courses, shallow: true
  end
  get "/pages/*page" => "pages#show"
  resources :institutes do
  	resources :courses, shallow: true
  end
  root "pages#show", page: "home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
