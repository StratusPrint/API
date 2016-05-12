class DownloadsController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  devise_token_auth_group :hub_or_user, contains: [:hub, :user]
  before_action :authenticate_hub_or_user!

  def download
    path = "#{Rails.root}/uploads/#{params[:resource]}/#{params[:id]}/#{params[:attachment]}/#{params[:basename]}.#{params[:extension]}"
    if File.exists?(path)
      send_file path, :x_sendfile => true
    else
      render :json => {:errors => ['File not found']}, status: :not_found
    end
  end
end
