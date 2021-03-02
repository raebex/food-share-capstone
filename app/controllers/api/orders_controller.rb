class Api::OrdersController < ApplicationController

  before_action :authenticate_user

  def index
    if current_user.chef
      @orders = current_user.tickets.order(created_at: :desc)
    else
      @orders = current_user.orders.order(created_at: :desc)
    end
    
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
      carted_dishes.each do |carted_dish| 
        carted_dish.update(order_id: @order.id)
        carted_dish.update(status: "purchased")
      end

      render "show_order.json.jb"
    else
      render json: { errors: @order.errors.full_messages }, status: :bad_request
    end
  end

  def show
    if current_user.chef
      @order = current_user.tickets.find(params[:id])
    else
      @order = current_user.orders.find(params[:id])
    end

    render "show.json.jb"
  end

  def destroy
    order = current_user.orders.find(params[:id])

    if order && Time.now < order.ready_time
      order.update(status: "cancelled")
      render json: { message: "Order cancelled" }
    else
      render json: { message: "Order cannot be cancelled" }
    end
    
  end
end
