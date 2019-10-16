class Submission < ApplicationRecord


  belongs_to :user 
  belongs_to :animal, optional: true

  enum purpose: { adoption: 1, relinquishment: 2}
  enum status: { approved: 1, denied: 2, pending: 3}

  def deny_all
    animal.submissions.pending.update_all(status: "denied")
  end

  def finalize!
    approval_processed
    animal.submissions.pending.each(&:denial_processed)
  end

  def approval_processed
    update(status: "approved")

    message = "From Friends of Scales Reptile Rescue: Congratulations! Your application has been approved! Please contact us to schedule a pick up/drop off time!"
    TwilioTextMessenger.new(message).call(user)
  end

  def denial_processed
    update(status: "denied")

    message = "From Friends of Scales Reptile Rescue: Hello! Unfortunately your application has been denied at this time, the animal you a wanted to adopt may have found a home already, or the rescue may not have room for your relinquishment at this time, contact us with specific questions if necessary!"
    TwilioTextMessenger.new(message).call(user)
  end

end
