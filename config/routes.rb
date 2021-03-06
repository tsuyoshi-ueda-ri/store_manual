Rails.application.routes.draw do
  devise_for :users
  root 'movies#top'
  resources :movies do
    resources :comments, :only => [:create, :destroy]
    collection do
      get 'search'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
