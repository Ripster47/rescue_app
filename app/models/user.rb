class User < ApplicationRecord
  has_secure_password

  has_many :submissions
  has_many :animals, through: :submissions

  validates :email, presence: true, uniqueness: true

  enum accommodations: { Apartment: 1, Condominium: 2, House: 3, Other: 4}

  def formatted_phone
    twilio_number = "+1#{phone_number.gsub(/\D/, "")}"
  end




end
