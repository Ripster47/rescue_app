class Api::SubmissionsController < ApplicationController
  # before_action :authenticate_user

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
      render 'show.json.jbuilder'
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
