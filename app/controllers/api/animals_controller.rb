class Api::AnimalsController < ApplicationController

  def index
    @animals = Animal.all
    render 'index.json.jbuilder'
  end

  def create
    @animal = Animal.new(
                        name: params[:name],
                        species: params[:species],
                        description: params[:description],
                        adoptable: params[:adoptable],
                        medical_status: params[:medical_status],
                        gender: params[:gender],
                        age: params[:age],
                        image_url: params[:image_url],
                        donation: params[:donation]
                        )
    if @animal.save
      render 'show.json.jbuilder'
    else
      render json: {errors: @animal.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def show
    @animal = Animal.find(params[:id])
    render 'show.json.jbuilder'
  end

  def update
    @animal = Animal.find(params[:id])

    @animal.name = params[:name] || @animal.name
    @animal.species = params[:species] || @animal.species
    @animal.description = params[:description] || @animal.description
    @animal.adoptable = params[:adoptable] || @animal.adoptable
    @animal.medical_status = params[:medical_status] || @animal.medical_status
    @animal.gender = params[:gender] || @animal.gender
    @animal.age = params[:age] || @animal.age
    @animal.image_url = params[:image_url] || @animal.image_url
    @animal.donation = params[:donation] || @animal.donation

    if @animal.save
      render 'show.json.jbuilder'
    else
      render json: {errors: @animal.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    animal = Animal.find(params[:id])
    animal.destroy
    render json: {Message: "Successfully Removed!"}
  end


end
