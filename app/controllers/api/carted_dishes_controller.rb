class Api::CartedDishesController < ApplicationController
  before_action :authenticate_user

  def index
    @carted_dishes = current_user.carted_dishes.where(status: "carted")

    render "index.json.jb"
  end

  def create
  #   carted_dishes = current_user.carted_dishes.where(status: "carted")
  #   existing_carted_dish = carted_dishes.find { |carted_dish| carted_dish.dish_id == params[:dish_id]}
    
  #  if existing_carted_dish
  #   existing_carted_dish.quantity = params[:quantity]
  #   existing_carted_dish.save
  #  else
      carted_dish = CartedDish.new(
        dish_id: params[:dish_id],
        quantity: params[:quantity],
        status: "carted",
        user_id: current_user.id
      )

      if carted_dish.save
        render json: { message: "Dish added to cart!" }, status: :created
      else
        render json: { errors: carted_dish.errors.full_messages }, status: :bad_request
      end
    # end
  end

  def update
    carted_dish = CartedDish.find(params[:id])
    carted_dish.quantity = params[:quantity] || carted_dish.quantity

    if carted_dish.save
      render json: { message: "Dish quantity updated!" }
    else
      render json: { errors: dish.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    carted_dish = CartedDish.find(params[:id])
    carted_dish.destroy

    render json: { message: "Dish removed from cart!" }
  end
end
