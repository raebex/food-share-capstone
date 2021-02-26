class Api::DishesController < ApplicationController
  before_action :authenticate_chef, except: [:show]

  def show
    @dish = Dish.find(params[:id])

    render "show.json.jb"
  end

  def create
    dish = Dish.new(
      name: params[:name],
      price: params[:price],
      description: params[:description],
      user_id: current_user.id,
      image_url: params[:image_url],
      portion_size: params[:portion_size],
      featured: params[:featured]
    )

    if dish.save
      render json: { message: "Dish created successfully" }, status: :created
    else
      render json: { errors: dish.errors.full_messages }, status: :bad_request
    end
  end
end
