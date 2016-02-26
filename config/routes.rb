Rails.application.routes.draw do
  scope module: 'api' do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: '/user/auth'
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
end

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

# Serve websocket cable requests in-process
# mount ActionCable.server => '/cable'
