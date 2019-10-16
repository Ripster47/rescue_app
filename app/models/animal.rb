class Animal < ApplicationRecord
  
  has_many :submissions
  has_one_attached :photo

  enum gender: {Male: 1, Female: 2}

end
