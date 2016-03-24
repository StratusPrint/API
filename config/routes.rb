8Rails.application.routes.draw do
  #devise_for :hubs, :users
  mount_devise_token_auth_for 'Hub', at: 'v1/hub_auth'
  mount_devise_token_auth_for 'User', at: 'v1/auth'
  scope module: 'api' do
    namespace :v1 do
      resources :hubs, shallow: true do
        resources :printers do
          resources :jobs
        end
        resources :sensors do
          resources :data, :controller => :data_points
        end
      end
    end
  end
  resources :apidocs, only: [:index]
end

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

# Serve websocket cable requests in-process
# mount ActionCable.server => '/cable'
