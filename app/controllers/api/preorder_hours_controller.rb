class Api::PreorderHoursController < ApplicationController
  before_action :authenticate_chef

  def create
    preorder_hour = PreorderHour.new(
      day_of_week: params[:day_of_week],
      open: params[:open],
      close: params[:close],
      user_id: current_user.id
    )

    if preorder_hour.save
      render json: { message: "Hours for #{preorder_hour.day_of_week} saved" }, status: :created
    else
      render json: { errors: preorder_hour.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    preorder_hour = PreorderHour.find(params[:id])
    preorder_hour.destroy

    render json: { message: "Hours successfully deleted!" }
  end
end
