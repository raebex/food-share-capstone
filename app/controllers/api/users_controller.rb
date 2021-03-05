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
      image_url: params[:image_url],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      chef: params[:chef],
      phone: params[:phone],
      address: params[:address],
      bio: params[:bio]
    )
    if @user.save
      render "show.json.jb"
    else
      render json: { errors: @user.errors.full_messages }, status: :bad_request
    end
  end

  def update
    @user = User.find_by(id: params[:id])

    if @user == current_user
      @user.first_name = params[:first_name] || @user.first_name
      @user.last_name = params[:last_name] || @user.last_name
      @user.email = params[:email] || @user.email
      @user.image_url = params[:image_url] || @user.image_url

      if params[:password]
        @user.password = params[:password]
        @user.password_confirmation = params[:password_confirmation]
      end

      @user.chef = params[:chef] || @user.chef
      @user.phone = params[:phone] || @user.phone
      @user.address = params[:address] || @user.address
      @user.bio = params[:bio] || @user.bio

      if @user.save
        update_cuisines if params[:cuisine_ids]
        update_preorder_hours if params[:preorder_hours]

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
    @user.cuisines.destroy_all
    eval(params[:cuisine_ids]).each do |cuisine_id|
      UserCuisine.create(user_id: @user.id, cuisine_id: cuisine_id)
    end
  end

  def update_preorder_hours
    @user.preorder_hours.destroy_all

    eval(params[:preorder_hours]).each do |preorder_hour|
      PreorderHour.create(
        day_of_week: preorder_hour[:day_of_week],
        open: preorder_hour[:open],
        close: preorder_hour[:close],
        user_id: @user.id,
      )
    end
  end
end
