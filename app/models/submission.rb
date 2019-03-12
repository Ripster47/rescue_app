class Submission < ApplicationRecord


  belongs_to :user
  belongs_to :animal

  enum purpose: { adoption: 1, relinquishment: 2}
  enum status: { approved: 1, denied: 2, pending: 3}

  

end
