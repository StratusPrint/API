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
  end

  validates :email, :uniqueness => true

  attr_accessor :current_password

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
end
