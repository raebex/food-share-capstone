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
            name: "Dishes from #{params[:chef_name]}",
          },
          unit_amount: (params[:total] * 100).to_i,
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: "http://localhost:8080/orders/create?delivery=#{params[:delivery]}&ready_time=#{params[:ready_time]}",
      cancel_url: 'http://localhost:8080/cart',
    })

    @stripe_id = session.id

    render "stripe.json.jb"
  end

  def create
    # create route just for creating stripe session
    # returns the session id, frontend redirects to stripe page
    # success url -> localhost:8080/orders/new include query params for delivery and ready_time
    # frontend view creates order (no html) imports axios runs axios to create new order
    # router push to orders show

    @order = Order.new(
      user_id: current_user.id,
      delivery: params[:delivery],
      ready_time: params[:ready_time],
      status: "received"
    )

    carted_dishes = current_user.carted_dishes.where(status: "carted")

    @order[:subtotal] = 0
    carted_dishes.each do |carted_dish| 
      @order[:subtotal] += carted_dish.dish.price * carted_dish.quantity 
    end

    @order[:chef_id] = carted_dishes.first.dish.user_id

    if @order.save
      # send_sms('+18 286046197', "+1#{current_user.phone}", "+1#{@order.chef.phone}", @order)
      carted_dishes.each do |carted_dish| 
        carted_dish.update(order_id: @order.id)
        carted_dish.update(status: "purchased")
      end

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
