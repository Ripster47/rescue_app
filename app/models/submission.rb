class Submission < ApplicationRecord


  belongs_to :user 
  belongs_to :animal, optional: true

  enum purpose: { adoption: 1, relinquishment: 2}
  enum status: { approved: 1, denied: 2, pending: 3}

  def deny_all
    submission = Submission.all
    submission.animal.submissions.pending.update_all(status: "denied")
  end

end
