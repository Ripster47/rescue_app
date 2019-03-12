class Animal < ApplicationRecord
  
  has_many :submissions

  enum gender: {male: 1, female: 2}

end
