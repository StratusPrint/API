class User < ApplicationRecord
  swagger_schema :User do
    property :id do
      key :type, :integer
      key :description, 'The unique ID of the user'
    end
    property :name do
      key :type, :string
      key :description, 'The name of the user'
    end
    property :image do
      key :type, :string
      key :description, 'The user\'s profile image'
    end
    property :email do
      key :type, :string
      key :description, 'The user\'s e-mail address'
    end
    property :admin do
      key :type, :boolean
      key :description, 'Whether the user has admin priveleges or not'
    end
    property :last_sign_in_ip do
      key :type, :string
      key :description, 'The IP address the user has last signed in with'
    end
    property :last_sign_in_at do
      key :type, :string
      key :description, 'The last time that the user signed in'
    end
    property :created_at do
      key :type, :string
      key :description, 'When the user was created'
    end
  end

  validates :email, :uniqueness => true

  attr_accessor :current_password

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
end
