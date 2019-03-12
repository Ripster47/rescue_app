class User < ApplicationRecord
  has_secure_password

  has_many :submissions
  has_many :animals, through: :submissions

  validates :email, presence: true, uniqueness: true


end
