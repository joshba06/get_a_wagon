class BookingsController < ApplicationController

  def create
    @booking = Booking.new(booking_params)
    @booking.car_id = params[:car_id]
    @booking.user_id = current_user.id
    if @booking.save
      redirect_to mybookings_path
    else
      redirect_to car_path(@booking.car_id), status: :unprocessable_entity
    end

  end

  def confirm
    @booking = Booking.find(params[:id])
    @booking.status = "confirmed"
    @booking.save
    if @booking.user == current_user
      redirect_to mybookings_path, status: :see_other
    else
      redirect_to host_dashboard_path, status: :see_other
    end
  end

  def cancel
    @booking = Booking.find(params[:id])
    @booking.status = "cancelled"
    @booking.save
    if @booking.user == current_user
      redirect_to mybookings_path, status: :see_other
    else
      redirect_to host_dashboard_path, status: :see_other
    end

  end

  def decline
    @booking = Booking.find(params[:id])
    @booking.status = "declined"
    @booking.save
    if @booking.user == current_user
      redirect_to mybookings_path, status: :see_other
    else
      redirect_to host_dashboard_path, status: :see_other
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:pickup_date, :dropoff_date, :car_id)
  end
end
