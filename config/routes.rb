Rails.application.routes.draw do
  
  
  
  devise_for :users
  resources :projects do
    resources :bugs do
      resources :comments
      end
  end
  root "home#index"
  post '/projects/:project_id/bugs/:id', to: 'bugs#pick', as: :pick
  post '/projects/:project_id/bugs/:id/drop', to: 'bugs#drop', as: :drop
  post '/projects/:project_id/bugs/:id/status', to: 'bugs#status', as: :status
end
