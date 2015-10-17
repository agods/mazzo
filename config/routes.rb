Rails.application.routes.draw do

  get 'lots/new'

  get 'lots/create'

  get 'notifications/index'

  get 'notifications/create'

  get 'activities/index'

  mount Upmin::Engine => '/admin'
  
  authenticated do
    root :to => 'dashboards#index', as: :authenticated
  end
  devise_scope :user do 
    root to: "devise/sessions#new" 
  end
  
  devise_for :users
  resources :users
  resources :notifications
  resources :design_applications do
	member do
	    put "like", to: "design_applications#upvote"
	    put "dislike", to: "design_applications#downvote"
      put :approve, to: "design_applications#approve"
      put :reject, to: "design_applications#reject"
	end
  end
  
  resources :activities

  resources :comments, only: [:index, :create]
  get '/comments/new/(:parent_id)', to: 'comments#new', as: :new_comment

  resources :tags, only: [:index, :show]
  resources :dashboards
  resources :lots

end
