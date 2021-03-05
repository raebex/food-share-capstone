class Api::CartedDishesController < ApplicationController
  before_action :authenticate_user

  def index
    @carted_dishes = current_user.carted_dishes.where(status: "carted")

    render "index.json.jb"
  end

  def create
    carted_dishes = current_user.carted_dishes.where(status: "carted")

    if carted_dishes.find_by(dish_id: params[:dish_id])
      @carted_dish = carted_dishes.find_by(dish_id: params[:dish_id])
      @carted_dish.update(quantity: @carted_dish.quantity + 1)
    else
      @carted_dish = CartedDish.new(
        dish_id: params[:dish_id],
        quantity: params[:quantity],
        status: "carted",
        user_id: current_user.id
      )
    end

    if @carted_dish.save
      render "show.json.jb"
    else
      render json: { errors: @carted_dish.errors.full_messages }, status: :bad_request
    end
  end

  def update
    @carted_dish = CartedDish.find(params[:id])
    @carted_dish.quantity = params[:quantity] || @carted_dish.quantity

    if @carted_dish.save
      render "show.json.jb"
    else
      render json: { errors: @carted_dish.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    carted_dish = CartedDish.find(params[:id])
    carted_dish.update(status: "removed")

    render json: { message: "Dish removed from cart!" }
  end
end
