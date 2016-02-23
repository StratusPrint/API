class User < ActiveRecord::Base
  validates :email, :uniqueness => true
  validates :provider, :uniqueness => true

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
end
