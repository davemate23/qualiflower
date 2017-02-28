Rails.application.routes.draw do
	
  devise_for :users
  resources :jobs do
    collection do
      get 'search'
    end
  end
  resources :comments
  resources :accreditations
  resources :locations do
    collection do
      get 'search'
    end
  end
  get "/pages/*page" => "pages#show"
  get 'courses' => 'courses#index', as: :courses
  resources :courses, only: [:index] 
    collection do
      get 'search'
    end
  resources :institutes do
  	resources :courses
    collection do
      get 'search'
    end
  end
  root "pages#show", page: "home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
