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
    user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      image_url: params[:image_url],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      chef: params[:chef],
      phone: params[:phone],
      address: params[:address],
      bio: params[:bio]
    )
    if user.save
      render json: { message: "User created successfully" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def update
    @user = User.find_by(id: params[:id])

    if @user == current_user
      @user.first_name = params[:first_name] || @user.first_name
      @user.last_name = params[:last_name] || @user.last_name
      @user.email = params[:email] || @user.email
      @user.image_url = params[:image_url] || @user.image_url
      # @user.password = params[:password] || @user.password
      # @user.password_confirmation = params[:password_confirmation] || @user.password_confirmation
      @user.chef = params[:chef] || @user.chef
      @user.phone = params[:phone] || @user.phone
      @user.address = params[:address] || @user.address
      @user.bio = params[:bio] || @user.bio

      if @user.save
        render "show.json.jb"
      else
        render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
      end
    else
      render json: {}, status: :unauthorized
    end
  end

  def destroy
    if @user == current_user
      user = User.find(params[:id])
      user.destroy

      render json: { message: "Successfully deleted user!" }
    else
      render json: {}, status: :unauthorized
    end
  end
end
