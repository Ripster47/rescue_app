class User < ApplicationRecord
  has_secure_password

  has_many :submissions
  has_many :animals, through: :submissions

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true
  validates :address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true


  enum accommodations: { Apartment: 1, Condominium: 2, House: 3, Other: 4}

  def formatted_phone
    twilio_number = "+1#{phone_number.gsub(/\D/, "")}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end


end
