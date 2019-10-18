class User < ApplicationRecord
  has_secure_password

  has_many :posts

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password_digest, presence: true
end
