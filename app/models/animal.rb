class Animal < ApplicationRecord
  
  has_many :submissions

  enum gender: {Male: 1, Female: 2}

end
