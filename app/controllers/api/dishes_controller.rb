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

  def update
    @dish = Dish.find(params[:id])
    @dish.name = params[:name] || @dish.name
    @dish.price = params[:price] || @dish.price
    @dish.description = params[:description] || @dish.description
    @dish.image_url = params[:image_url] || @dish.image_url
    @dish.portion_size = params[:portion_size] || @dish.portion_size
    @dish.featured = params[:featured] || @dish.featured

    if @dish.save
      render "show.json.jb"
    else
      render json: { errors: dish.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    dish = Dish.find(params[:id])
    dish.destroy

    render json: { message: "Successfully deleted dish!" }
  end
end
