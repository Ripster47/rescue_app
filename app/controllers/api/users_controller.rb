class Api::UsersController < ApplicationController

  def index
      @users = User.all
      render 'index.json.jbuilder'
  end

  def create
    user = User.new(
                    first_name: params[:first_name],
                    last_name: params[:last_name],
                    email: params[:email],
                    password: params[:password],
                    password_confirmation: params[:password_confirmation],
                    phone_number: params[:phone_number],
                    address_1: params[:address_1],
                    address_2: params[:address_2],
                    city: params[:city],
                    state: params[:state],
                    zip_code: params[:zip_code]
                    )
    if user.save
      render json: {message: 'User created successfully'}, status: :created
    else
      render json: {errors: user.errors.full_messages}, status: :bad_request
    end    
  end

  def show
    @user = User.find(params[:id])
    render 'show.json.jbuilder'
  end

  def update
    @user = User.find(params[:id])

    @user.first_name = params[:first_name] || @user.first_name
    @user.last_name = params[:last_name] || @user.last_name
    @user.email = params[:email] || @user.email
    @user.password = params[:password] || @user.password
    @user.password_confirmation = params[:password_confirmation] || @user.password_confirmation
    @user.phone_number = params[:phone_number] || @user.phone_number
    @user.address_1 = params[:address_1] || @user.address_1
    @user.address_2 = params[:address_2] || @user.address_2
    @user.city = params[:city] || @user.city
    @user.state = params[:state] || @user.state
    @user.zip_code = params[:zip_code] || @user.zip_code

    if @user.save
      render 'show.json.jbuilder'
    else
      render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: {Message: "Successfully Removed!"}
  end

end
