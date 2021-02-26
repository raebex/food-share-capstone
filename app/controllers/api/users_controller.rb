class Api::UsersController < ApplicationController
  def index
    @users = User.where(chef: true).joins(:dishes).distinct
    render "index.json.jb"
  end

  def show
    @user = User.find(params[:id])

    if @user.chef || @user == current_user
      render "show.json.jb"
    else
      render json: { message: "You're not allowed to see this page" }, status: :unauthorized
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

end
