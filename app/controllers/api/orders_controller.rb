class Api::OrdersController < ApplicationController

  before_action :authenticate_user

  def index
    @orders = current_user.orders.order(created_at: :desc)
    @tickets = current_user.tickets.order(created_at: :desc)
    
    render "index.json.jb"
  end

  def create
    @order = Order.new(
      user_id: current_user.id,
      delivery: params[:delivery],
      ready_time: params[:ready_time],
      status: "received"
    )

    carted_dishes = current_user.carted_dishes.where(status: "carted")

    @order[:subtotal] = 0
    carted_dishes.each {|carted_dish| @order[:subtotal] += carted_dish.dish.price * carted_dish.quantity }

    @order[:chef_id] = carted_dishes.first.dish.user_id

    if @order.save
      render "show.json.jb"
    else
      render json: { errors: @order.errors.full_messages }, status: :bad_request
    end
  end
end
