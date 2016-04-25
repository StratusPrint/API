Rails.application.routes.draw do
  resources :commands
  mount_devise_token_auth_for 'Hub', at: 'v1/hub_auth'
  mount_devise_token_auth_for 'User', at: 'v1/auth', controllers: {
    registrations: 'overrides/registrations'
  }
  scope module: 'api' do
    namespace :v1 do
      resources :hubs, shallow: true do
        resources :printers do
          resources :jobs
          resources :commands
          member do
            get 'current_job', :action => 'show_current_job'
            get 'queued_jobs', :action => 'show_queued_jobs'
            get 'processing_jobs', :action => 'show_processing_jobs'
          end
        end
        resources :sensors do
          resources :data, :controller => :data_points
        end
        member do
          get 'statistics', :action => 'show_statistics'
          post 'api_key', :action => 'generate_api_key'
        end
      end
      resources :users
    end
  end
  resources :apidocs, only: [:index]
  get '/uploads/:resource/:id/:attachment/:basename.:extension', :controller => 'downloads', :action => 'download', via: :get
end

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

# Serve websocket cable requests in-process
# mount ActionCable.server => '/cable'
