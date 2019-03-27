require './app/services/twilio_text_messenger.rb'

class Api::SubmissionsController < ApplicationController
  before_action :authenticate_admin, except: :create



  def index
    @submissions = Submission.all
    render 'index.json.jbuilder'
  end

  def index_pending
    @submissions = Submission.where("status = ?", 3)
    render 'index.json.jbuilder'
  end

  def create
    @submission = Submission.new(
                                  user_id: current_user.id,
                                  animal_id: params[:animal_id],
                                  purpose: params[:purpose],
                                  status: "pending",
                                  relinquish_reason: params[:relinquish_reason],
                                  animal_type: params[:animal_type]
                                  )
    
    if @submission.save
      if @submission.purpose == "adoption"
        message = "There is a new adoption application awaiting your review!"
        TwilioTextMessenger.new(message).call_admin
      else
        message = "There is a new relinquishment application awaiting your review!"
        TwilioTextMessenger.new(message).call_admin
      end
    else
      render json: {errors: @submission.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def show
    @submission = Submission.find(params[:id])
    render 'show.json.jbuilder'
  end

  def update
    @submission = Submission.find(params[:id])

    @submission.user_id = params[:user_id] || @submission.user_id
    @submission.animal_id = params[:animal_id] || @submission.animal_id
    @submission.purpose = params[:purpose] || @submission.purpose
    @submission.status = params[:status] || @submission.status
    @submission.relinquish_reason = params[:relinquish_reason] || @submission.relinquish_reason
    @submission.animal_type = params[:animal_type] || @submission.animal_type


    if @submission.save
      if @submission.status == "approved"
        message = "From Friends of Scales Reptile Rescue: Congratulations! Your application has been approved! Please check your email for your scheduled appointment time!"
        TwilioTextMessenger.new(message).call(@submission.user)
      else @submission.status == "denied"
        message = "From Friends of Scales Reptile Rescue: Hello! Unfortunately your application has been denied at this time, the animal you a wanted to adopt may have found a home already, or the rescue may not have room for your relinquishment at this time, contact us with specific questions if necessary!"
        TwilioTextMessenger.new(message).call(@submission.user)
      end
      render 'show.json.jbuilder'
    else
      render json: {errors: @submission.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    submission = Submission.find(params[:id])
    submission.destroy
    render json: {Message: "Successfully Removed!"}
  end



end
