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

  def checkout
    Stripe.api_key = Rails.application.credentials.stripe[:api_key]
    session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          product_data: {
            name: "Dishes from #{params[:chef]}",
          },
          unit_amount: params[:price],
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: "http://localhost:8080/orders",
      cancel_url: 'http://localhost:8080/cart',
    })

    @stripe_id = session.id

    render "stripe.json.jb"
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

    p @order.ready_time

    if @order.save
      carted_dishes.each do |carted_dish| 
        carted_dish.update(order_id: @order.id)
        carted_dish.update(status: "purchased")
      end

      send_sms('+18286046197', "+1#{current_user.phone}", "+1#{@order.chef.phone}", @order)

      render "show.json.jb"
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

  private

  def send_sms(twilioPhone, patronPhone, chefPhone, order)
    account_sid = Rails.application.credentials.twilio[:account_sid]
    auth_token = Rails.application.credentials.twilio[:auth_token]
    client = Twilio::REST::Client.new(account_sid, auth_token)

    client.messages.create(
      from: twilioPhone,
      to: patronPhone,
      body: "Woohoo! Your order with Chef #{order.chef.first_name} will be ready on #{order.ready_time.strftime('%b %e,%l:%M %p')}"
    )

    client.messages.create(
      from: twilioPhone,
      to: chefPhone,
      body: "Woohoo! You have a new order from #{order.user.first_name} that should be ready on #{order.ready_time.strftime('%b %e,%l:%M %p')}. Login to your account to view more details."
    )
  end
end
