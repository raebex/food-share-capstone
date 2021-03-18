class Api::UsersController < ApplicationController
  before_action :authenticate_user, except: [:index, :show, :create]

  def index
    @users = User.where(chef: true).joins(:dishes).distinct
    render "index.json.jb"
  end

  def show
    @user = User.find(params[:id])

    if @user.chef || @user == current_user
      render "show.json.jb"
    else
      render json: {}, status: :unauthorized
    end
  end

  def create
    @user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      chef: params[:chef]
    )
    if @user.save
      render "show.json.jb"
    else
      render json: { errors: @user.errors.full_messages }, status: :bad_request
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    response = Cloudinary::Uploader.upload(params[:image_url], resource_type: :auto)
    cloudinary_url = response["secure_url"]

    if @user == current_user
      @user.first_name = params[:first_name] || @user.first_name
      @user.last_name = params[:last_name] || @user.last_name
      @user.email = params[:email] || @user.email
      @user.image_url = cloudinary_url || @user.image_url

      if params[:password]
        @user.password = params[:password]
        @user.password_confirmation = params[:password_confirmation]
      end

      @user.chef = params[:chef] || @user.chef
      @user.phone = params[:phone] || @user.phone
      @user.street = params[:street] || @user.street
      @user.city = params[:city] || @user.city
      @user.state = params[:state] || @user.state
      @user.zip_code = params[:zip_code] || @user.zip_code
      @user.bio = params[:bio] || @user.bio

      if @user.save
        update_cuisines if params[:cuisine_ids]
        render "show.json.jb"
      else
        render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
      end
    else
      render json: {}, status: :unauthorized
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user == current_user

      @user.destroy

      render json: { message: "Successfully deleted user!" }
    else
      render json: {}, status: :unauthorized
    end
  end

  private

  def update_cuisines
    @user.user_cuisines.each do |cuisine|
      cuisine.destroy
    end
    params[:cuisine_ids].each do |cuisine_id|
      UserCuisine.create(user_id: @user.id, cuisine_id: cuisine_id)
    end
  end
end
