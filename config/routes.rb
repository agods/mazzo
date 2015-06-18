Rails.application.routes.draw do

  mount Upmin::Engine => '/admin'
  
  authenticated do
    root :to => 'design_applications#index', as: :authenticated
  end

  root to: 'visitors#index'
  
  devise_for :users
  resources :users
  resources :design_applications do
	member do
	    put "like", to: "design_applications#upvote"
	    put "dislike", to: "design_applications#downvote"
	end
  end

  resources :comments, only: [:index, :create]
  get '/comments/new/(:parent_id)', to: 'comments#new', as: :new_comment

end
