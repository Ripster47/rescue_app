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
                    zip_code: params[:zip_code],
                    rent: params[:rent],
                    children: params[:children],
                    adult: params[:adult],
                    volunteer: params[:volunteer],
                    foster: params[:foster],
                    usark: params[:usark],
                    exotic_vet: params[:exotic_vet],
                    ever_owned: params[:ever_owned],
                    care: params[:care],
                    provisions: params[:provisions],
                    bequest: params[:bequest],
                    accommodations: params[:accommodations],
                    permit: params[:permit]
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
    @user.rent = params[:rent] || @user.rent
    @user.children = params[:children] || @user.children
    @user.adult = params[:adult] || @user.adult
    @user.volunteer = params[:volunteer] || @user.volunteer
    @user.foster = params[:foster] || @user.foster
    @user.usark = params[:usark] || @user.usark
    @user.exotic_vet = params[:exotic_vet] || @user.exotic_vet
    @user.ever_owned = params[:ever_owned] || @user.ever_owned
    @user.care = params[:care] || @user.care
    @user.provisions = params[:provisions] || @user.provisions
    @user.bequest = params[:bequest] || @user.bequest
    @user.accommodations = params[:accommodations] || @user.accommodations
    @user.permit = params[:permit] || @user.permit

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
